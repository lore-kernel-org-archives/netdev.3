Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4463A5E87
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242574; cv=none; b=LX5Q4WIe6Z+pp8okQ7sRhHE1tNmvoAFbNW5ZJvXySGxWsqBa/ix7d/SHPGFe8OKFu1TMxm3PUZhSMaAisKxCcxXDbxPD7EfZCTn4IvGDcgwr73v54gxcK6PLNPWMXQjdszUArSIi5HygZnL21NloffDgO0unlLu51z3hsy1r5Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242574; c=relaxed/simple;
	bh=TIBXLVpu3P6njrqobBE78+Uft6aHC9UBtcy9JkXN4PM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nB2IF2yVSbx63RQMaNVJhsGHRq2zHHgDB/b1jDps2hptWcEiFY7BB4q7MM7aKwu6FxhGDcUpsEC3ksQ+qmD5OEgC+SnC/rGvqXd0XJUmgdNz/r69kCS1Lub6x2gGU0HILAf1yX+A3qYrOciK5oFnk6LNzWa8PET+2JzspWmiNdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jtRzq49l; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtRzq49l"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccc02279so1166872a91.1
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242572; x=1790847372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jgrohmt14ZqMIQv1HD1kxLIsELyeYSK07XxKwKFPOeU=;
        b=jtRzq49ljyyLIqJODVeq+aM1aasGzmiKF3RbxfsBTtlaNBLeW6YT0OuSq3eu/67Kas
         X2Y+hWC4d4z//jTm3spk6PY+9tLNzIHboialNZlT6rVM33TW7BWJ3UotMi/BwzaI3wC6
         lXmZPFUGuPVvFxQBaa2At/CiGFD8xtRAINRu+/MwAHruPSSZcV74BHZwH5tfe91gAI7g
         i8/Y8v/k/PbVzrkFmUKnuSoYH6F7C3wnfT40mcAjzGRcT56logFL28kBfFUM+HB0mAMl
         ojMj1VBo3qPsit6BL70ttTpKsKJ+urz82FMVCuMw2kz+kAbONBU3iYh4AJkXqqkw70sb
         lNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242572; x=1790847372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jgrohmt14ZqMIQv1HD1kxLIsELyeYSK07XxKwKFPOeU=;
        b=gbCEsTYrP/5NodUUqQ0RdwIbXHXuLmyFVsZufUP/7TWtiv3tMKZYD3jKWGlzMrSeuc
         xUR5uirjRv6It+eqeK5MMtSp/WYnpyIdFINOlj9+tF+WuIWh5pPbYOHylyqdQdTBySh2
         5bybh1bdCU9FukZgxb9pQT3FBxyGec2t9o6RTRSujm+jnGZiEQIqqmdO3ycgpt6iT2e6
         LkYIDjDraiOVsGaLYms2JBU0OkwhajGMTp6PcqD2CSEqvSqt/VJ4Vsfl//FHThRXgn3I
         ETreuHgCZNtUs/2+50lA9XXtOF8050V04ScW/oH/jx+f/hOp028X+QRqpiGN9GA3+kBq
         B8Ng==
X-Gm-Message-State: AFuF++mzmNyIRMoeTr+99mkoLuhAn+ipNXxCZZbxKinLAG5agbsL/YbL
	cYQVSrRuEIxYsqf5rY5e2APOSBPkSox7US+6f/358Mko3ls2NjTi/eGZ
X-Gm-Gg: AYBFou1iqHZJnPjy16l1lLSJbi/Qe0nlXkwUhB8i7QpfhfVAYZyBpmhFT+qlcu3RzlF
	Nt6sEWjY+gKxIVA8EvC5Rpu60fxPoDiaaWfUAN8kZjCoi/mn6z3ugvQbiKo1YBbkHvY123mHL/V
	smm8xDYO9U7zi1dY95RDGv78Sk2T/yZ5obBRn6/AJXIIRPS/iUwVrhE5K4/ilv3zRhLtfT6x9/A
	Yfpd5+WOWDgTjpfXz+iizq0rwZPok9A/HvPKd2cVOfHHJwL7ttFFoaJUPbIcjX3DuSkUv7M5AEq
	8R6OikcZv6TzcaNVw3IxtBnpo5iZQRb68xen24dM6zzARkwer62vmeOc7rUJS1INu4XTkwLeYUm
	fkjs38GOLGo1k6EpP7A5CmiiG6EXaTU0z4V8+PqsqtaVqAW3PNPwPxyooso8P6veNQM7g/qwbos
	ZbunHAhqheD3kPU/U5e0mks70gMZv6dNv0X6H6j4hk3FNZEsQtQmg6H7yZroRAU5YNdUb4hIVS8
	xP/quksu1Kbga4+APcZ/wKxCRQMROXmlBMYUKhHWM0E+t4W4JoXpqX8+hVqtICxR5mBpBZ97+ns
	fqy+ZYTDug==
X-Received: by 2002:a17:90b:1d49:b0:39e:6c68:c777 with SMTP id 98e67ed59e1d1-3a098e0166bmr1585304a91.45.1790242572238;
        Thu, 24 Sep 2026 02:36:12 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972b22c3sm3939404a91.1.2026.09.24.02.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 02:36:11 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	andrea.mayer@uniroma2.it,
	hangbin.liu@linux.dev,
	leitao@debian.org,
	Hui Peng <benquike@gmail.com>
Subject: [PATCH net v4] ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST
Date: Thu, 24 Sep 2026 09:36:10 +0000
Message-ID: <20260924093610.3286959-1-benquike@gmail.com>
X-Mailer: git-send-email 2.56.0.rc1.310.g51773c2048-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In seg6_genl_policy, SEG6_ATTR_DST is defined with .type = NLA_BINARY and
.len = sizeof(struct in6_addr). For NLA_BINARY, .len only enforces the
maximum payload length and permits shorter payloads (e.g., 0 bytes).
When seg6_genl_set_tunsrc() copies sizeof(struct in6_addr) bytes via
kmemdup(val, sizeof(*val), GFP_KERNEL), a short SEG6_ATTR_DST attribute
triggers a 16-byte out-of-bounds read past skb->tail into uninitialized
skb->head memory, which is stored in sdata->tun_src and leaked back to
userspace via SEG6_CMD_GET_TUNSRC.

Switch SEG6_ATTR_DST in seg6_genl_policy to
NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)) so that generic netlink
validation rejects any attribute whose length is not exactly
sizeof(struct in6_addr) with -ERANGE.

Tested in QEMU against Linux 7.3.0-rc3 by sending a SEG6_CMD_SET_TUNSRC
Generic Netlink message with a 0-byte SEG6_ATTR_DST attribute followed
by SEG6_CMD_GET_TUNSRC. On the unfixed kernel, SEG6_CMD_SET_TUNSRC
succeeds (err = 0) and SEG6_CMD_GET_TUNSRC leaks 16 bytes of
uninitialized kernel heap memory; with this patch applied,
SEG6_CMD_SET_TUNSRC is rejected by netlink policy validation with
-ERANGE (-34) and tun_src remains zeroed.

Fixes: 915d7e5e5930 ("ipv6: sr: add code base for control plane support of SR-IPv6")
Cc: stable@vger.kernel.org
Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>
Reviewed-by: Hangbin Liu <hangbin.liu@linux.dev>
Reviewed-by: Breno Leitao <leitao@debian.org>
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v4:
- Drop raw hex memory dump string from commit message as suggested by Breno
  Leitao.
- Add Reviewed-by tag from Breno Leitao.

Changes in v3:
- Add Reviewed-by tag from Andrea Mayer.
- Send as a fresh standalone thread (no In-Reply-To header) as requested by
  Jakub Kicinski.

Changes in v2:
- Drop the redundant nla_len(info->attrs[SEG6_ATTR_DST]) !=
  sizeof(struct in6_addr) check in seg6_genl_set_tunsrc() since
  NLA_POLICY_EXACT_LEN() in seg6_genl_policy already enforces the exact
  length, as pointed out by Hangbin Liu.

 net/ipv6/seg6.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
index 62a7eb779202..8c2b156c227a 100644
--- a/net/ipv6/seg6.c
+++ b/net/ipv6/seg6.c
@@ -138,8 +138,8 @@ void seg6_icmp_srh(struct sk_buff *skb, struct inet6_skb_parm *opt)
 static struct genl_family seg6_genl_family;
 
 static const struct nla_policy seg6_genl_policy[SEG6_ATTR_MAX + 1] = {
-	[SEG6_ATTR_DST]				= { .type = NLA_BINARY,
-		.len = sizeof(struct in6_addr) },
+	[SEG6_ATTR_DST]				=
+		NLA_POLICY_EXACT_LEN(sizeof(struct in6_addr)),
 	[SEG6_ATTR_HMACKEYID]		= { .type = NLA_U32, },
 	[SEG6_ATTR_SECRET]			= { .type = NLA_BINARY, },
