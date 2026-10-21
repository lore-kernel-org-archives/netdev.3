Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598112;
	b=j6HHpPOwkzbeQJTMD+ljfaP5P3+PRySwf9o/aL9UFLseAa423fLaJxfizNNd/OHmERyE
	 7+ngQN/0axuKTCkHFEOTexa5pHFKFBx5Q4T8Qz4jcRahWzpQhCERo4nBI9ki8ov4g8zP+
	 asTFxDFuCNaKM3RJ8stdp78KNpFLsQpoDXcfu3NMSMsrSIOKHTCW1isOx+UffpZHOFXQN
	 SAyBPzb36G4cHbpkPvWzIjA0+07uYQiyrYjEfFxPJUf2fUkQcQ08S83yM4HCUV1CaIOTy
	 D9pcgt3oP/YK2l11vEeRAY8EgESS08yOS9UUiBdTQcrEKKjMN67XlaxJQz3X8AjZxHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598112;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=eWU2bVlaO64KjekmMIRHMOpynADD/F8s5EOK5FvSh1I=;
	b=b7PbWTfDmajRQI8aIrQcLsCTbScERAqX+1hVL1+v2EgHiSNZhY2cNm9S0ZKmmaQ7alQz
	 YRG0FxCBVBIyTL+q0mUt356U8/tqjpprGym+NB4LcKt1ZDvTFHDmpe3KKxAGi+NIbD6Nq
	 9SdsjRv6MXpCFr6/Nr/tH8FCGFJgcJuYe0PAfFqSI8umDf/YXSNHtORnUhHjRASuBD6xy
	 51eBRy60AMWNlCZYlgoHMNPFCuYfN7AjB9kH3scCE6YrBe2nXFk0fFd0/c8p/H/ZlL4L7
	 qwMddwTMLnexhhBE2YYe82b1sfVOaOtZvLDYGprxsmhmty5x7bdJzvWBxgvgrmIOuVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AGwbTHXu;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23522606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:55:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23522606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=AGwbTHXu
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ab9268d90eso571349a91.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598111; x=1793202911; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eWU2bVlaO64KjekmMIRHMOpynADD/F8s5EOK5FvSh1I=;
        b=AGwbTHXuya85RfypvX6CFIjkACpyctue6wii2WjTQ+ldve+tEzx65iAiEC2DbtA+FF
         IcTT9THDgYhB8F6M+A3Rzz6w6Rumo3JmpE2iEumgv2yxiWY9kaaID1t84QxZPAVQuF44
         61WDZ9epkpDwWYH8RMfpPPbhBmDaz3ro5rwaL1zhb/Glax+gYYuBnuYMc8dD3ibqkXAY
         bU7fTfDwBFXFyoBru/RtbNPwifh1CmFH5YGQbLuSTlBKk5snjFABHZgBQvmuPjrwmvVP
         ETix/cvnewbZae4ZJPxkm4h95Zu/MQcyhg6jOvmNASfKfiw9slFaq4uWh0fQ+0Iq7hNG
         Y7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598111; x=1793202911;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eWU2bVlaO64KjekmMIRHMOpynADD/F8s5EOK5FvSh1I=;
        b=nClYdkUV6yqSf37hyskdP58/+IlxU1M+dchmelNdv+w1xTqbGKSrT0oybzKg/4KKd6
         HZKWmrWNt+4KpAwghhUsUD6KfkrVQcmqyGs3DsJeB/mKhw6sysM5o0+w/TGI/8+cD514
         sIhnMYCafY2cxHy1O3T69SxpXJX/LkSHYJ03oDKrVlPJe+p26lYXPBcHlL2d1n9Za889
         1KirmMdkxGFSxkI0j3teFVYxEFZltmU/OqP+39FE/m71+LsHkpdoV0kIZlYJyAcK/vUv
         jC2I7GWYifI/HroznCfc1G6p8gw0W78YDz1ntysAbkOyctsQ1eBPTYhWyu9NWHtKFBxu
         A35A==
X-Gm-Message-State: AFq9FYJBI2RtPrW3j12T6GTbXY/vrNW4RetqrkaL6v4n3MABXnoQPCkb
	ZxOQ0bPeJYnSBenIuOHvcWpM7M1exrPUCi7kL1QZVtcxj1iEatRjci8l
X-Gm-Gg: AYBFou02PUc/adVsF4Gk97KR1+f/9QmFAlyrbr66CC72tVfpyzPqWxb4B3ZxpyCO5r3
	rFtbnLmCOsbww3rJAH+rt5zjq0uymTChI65W2Y1f0yz7fjZjYNID3D7DLlalc7w7Sa4HfvIEQp7
	cz9//omHGRTXAIzeUWiN+KUvscpXv18eh04Z+vlPmhPopTYAo5VUpDhJXMTM1CBkP+wmbEQGE31
	ik0ed4uqfRO2WfvksqhZf9QNTs56ZBjZ0pegLV4DG4pYW2e3mC6n+0+cgio+VmoJNo+XatrmWeh
	DlCe87E73VWWVQaofGQL4bHBMVY9Oxoe3PdjIVFkBr8rIKlQ27bnZkqtDpQPEmLf3AvCzajUyma
	2gFgLsyx9NbBpQTYPWmwaMJ2D3RFHdtB+NYFo7J6MqD2PBxkzGqIA7o1iRZqFoKoGrLgEBFnj6m
	WvNK1lRhyv70ITYxwllfX0iBEWEYQObpkyvqXnEch3W8WVQN8oXY/Xy1m2R3yDPXoZqlj7BvTnQ
	uDPYesGeKqBbTUyOuNPCk6PG937g113l5MXVcliUo3Rs0JLFD3o/MeCaWI8RbBkD2v+1CEPEUeE
	GvsFvoqq47uisG+vwDKHrS9UKdMfRCN6eiUItm+FbI7JkXpyAC8UztN5jG8=
X-Received: by 2002:a17:90b:3cc7:b0:3ac:d19e:85f1 with SMTP id 98e67ed59e1d1-3ad86d7e7b9mr1991380a91.53.1792598111346;
        Wed, 21 Oct 2026 08:55:11 -0700 (PDT)
Received: from localhost.localdomain (69-172-67-073.static.imsbiz.com. [69.172.67.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada49544f1sm60771a91.16.2026.10.21.08.55.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:55:10 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net] net: reject flow_limit_table_len values below 2
Date: Wed, 21 Oct 2026 23:55:05 +0800
Message-Id: <20261021155505.67208-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

flow_limit_table_len_sysctl() rejects non-powers-of-two but accepts 1,
which is 2^0.  A length of 1 then gives log_buckets = ilog2(1) = 0, and
skb_flow_limit() computes hash_32(hash, 0):

  include/linux/hash.h:68
	return __hash_32(val) >> (32 - bits);   /* bits == 0 -> shift by 32 */

A shift by 32 is undefined and, on arm64/x86, the "hash" becomes the full
32-bit product val * GOLDEN_RATIO_32 -- an unbounded index into a
buckets[] flex array that is one byte long inside a 289-byte allocation:

  UBSAN: shift-out-of-bounds in ./include/linux/hash.h:68:24
  shift exponent 32 is too large for 32-bit type 'unsigned int'
   __ubsan_handle_shift_out_of_bounds+0x11c/0x208
   enqueue_to_backlog+0xbe4/0xc44
   netif_rx_internal+0x130/0x4d4

The subsequent read-modify-write at dev.c:5443-5446 is an out-of-bounds
write into the allocation (also observed as use-after-free).  Require at
least two buckets so log_buckets is never 0.

Fixes: 99bbc7074190 ("rps: selective flow shedding during softnet overflow")
Assisted-by: LLM
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
Tested base
-----------
Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
is unchanged between the two, so the bug is still present there.
Checked against linux-next next-20261021 (commit 9a482184d910): the
affected code is unchanged there as well, so the bug is still present in
linux-next too.

Reproducer status
-----------------
A reproducer was written and executed on an arm64 QEMU guest (KASAN + UBSAN);
UBSAN fired at the claimed sink.  The reproducer source is not posted here per
Documentation/process/security-bugs.rst; it is available on request.

Triggering conditions
---------------------
root (flow_limit_table_len and netdev_max_backlog live only in the init-net
net_core_table, absent from the netns table).

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
0 warnings.

 net/core/sysctl_net_core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index eb35da3556f4..bb0fa69f94f5 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -283,7 +283,12 @@ static int flow_limit_table_len_sysctl(const struct ctl_table *table, int write,
 	ptr = table->data;
 	old = *ptr;
 	ret = proc_dointvec(table, write, buffer, lenp, ppos);
-	if (!ret && write && !is_power_of_2(*ptr)) {
+	/* A length of 1 is a power of two but gives log_buckets == 0,
+	 * which makes skb_flow_limit() compute hash_32(hash, 0) -- a
+	 * shift by 32 -- and index the one-byte buckets[] array with the
+	 * full 32-bit hash.  Require at least two buckets.
+	 */
+	if (!ret && write && (*ptr < 2 || !is_power_of_2(*ptr))) {
 		*ptr = old;
 		ret = -EINVAL;
 	}
