Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BBC451980
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788626317; cv=none; b=txY4Sj5mypIs602TISE+vuFDVSZltRGS52aYBZ7A+0113yrFUO5JUB92ScjHYWk8LUNkv/u+gzhiwOgCVDM4yXGukqJxoY2eZTi7vx6wiV+Nxdv0hlE46pBDQIG5a3MdZwJ/H4gYPQvfFkEjx7jD/Zsm2+nlAzb8f/MUiIMBAKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788626317; c=relaxed/simple;
	bh=3rYlH8LXVBW5SsYx659NfG0lyBaDhUqrzWQwq58K594=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=S8A4qTC4ivA8mnkP3VHSE3wdtRpIFRKhvCW3A9iManef6Y9VwlUwLJrlPKG2mR5OlLlnEhMYizOUV7dRA2C7b4EFrZe3RTCDoB7ltI4rzGpjtY8RwFLO3SHkdpidZkAP7NN+SlLY12NA9KwWv3O36ViCdNQR0Vn3qH5NAMh4030=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com; spf=pass smtp.mailfrom=doyensec.com; dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b=Za5GfO0T; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=doyensec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=doyensec.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=doyensec.com header.i=@doyensec.com header.b="Za5GfO0T"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a6868f18aeso3009339a12.0
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 09:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=doyensec.com; s=google; t=1788626314; x=1789231114; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=triNZ5qYyRouWDSU+cvR0dd2XFT1X3RzFe5HPcGxPww=;
        b=Za5GfO0T/q+zzQnnN2CGYAbyZl5gLrr0uJvMES4K8gW1GDUHPZ29sHcV/9Fu4RHsH2
         w6BDa95PZMW7p3wCaRsfoMLu+uxDPRTMibpIMtRiAG57f9paVmKOims/lDkG0AS+DkYy
         awFpFx3p9mkUOe6Rro5ouP7l4ml07VPG/8eeDU940wUxNDWmJ38C8vCzyhrmH68lEUMI
         Nao1k7YGCWBw7Tn52IqVrcAW4CxJWlEqJIcNUj1TaGJhGYMcke8cunb1sWRowlkIsbUT
         //IFf8HHF7RH8sVMrHPq5lir68LXagcAKSNgu/RihruwodP8ATxLlxdiwNhimM3kp/IF
         6mHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788626314; x=1789231114;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:content-type:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=triNZ5qYyRouWDSU+cvR0dd2XFT1X3RzFe5HPcGxPww=;
        b=TtA1R0HnNptrCXF9XlK2151H7YsDUDZAK7wzdEMfpbfVOWE74a4InRF7c531VRkw5H
         +DB2+0Dje1e7VlhHyBppITEp2YErquhAhU75rXYaGzGkURAzC4EUuQrjqSIZdKKPtFr4
         5ZCAg/JHUp9at3WsLYUXDwMSclIC5qLDOH755sHAjLSdHp8VI5Lz7WFzjXOv6aMSu9YD
         8rl5/zWJ4b6b+6bzrCV3ttIaAIVGelafRucihMAtzQurNmpRbARw2fbv/LtWXDuFaqcp
         tCFu3clT/iEsNIvSu4oI4shCllaqXyclTKZUpk+nufy/Gv9cOLPiEkeiAGh+iprpPA9A
         6zKg==
X-Gm-Message-State: AFuF++lJE/sl+BKmHCHM59ijWnU792FNQ9Dp0wlT+A7Oa4oscxulXblk
	bI1GsWw2DTOePb/qmgXPWTfFiC7P8/0OlbxzYsbNqe+shmW+O6jywnB0x468lkW1HVMPuc7x9rH
	lkMg2zOZPlw==
X-Gm-Gg: AYBFou231Z5lml1Ib9RlIuw43MmpTZ83hiJKKL2ExeH+biGbcq3jQdgr687olPubstl
	ADeNw7GH2RzuE81diFw81EIKfCsg5OcO37Svf23ANlgzLbWJyfClkZ4LQclGggOX2Uo82TldLJj
	kDrV7fCdPs6MMt7WPLmMZjDuFCRc1+hsF/MphQYgKCqljZ9olLoPgXFkSUv0Y/DjyI3TvjO8UAm
	yUz5nVEi3Sm8aQsTrB4p/E6zOIW2z25qq8kI1ProKtNaJ9SsAzYua3f+uErH3CLZZktCVTJ+ooo
	bxbN2SMHc+odBV0QwZIlwCdD4vjSpmuv+S4GuugDzGjy5R9ePY1xllloAwJzj1aHBl5W8qMdcgW
	mIyq00CC3fJCX5KWES0oNC2wMNcWtFIfpa28VgNrSdMttFPNDkaxcDAUPWobEdXFtsYTMe0LjFa
	sGUALldhE4tz0aWkwuhTPYd0pwETsZ0ZG4lFnd8PVk1WIBl8VkDQp9rcKbnYWOhH6p291xWyU/S
	UHkfLGTO6QfjNd/ulE84LDICCpYZcdjgVEuJ+W5E1lynBowlnpz
X-Received: by 2002:a05:6402:218b:10b0:6a7:f2d5:dfcc with SMTP id 4fb4d7f45d1cf-6a7f2d5e240mr2090775a12.36.1788626313718;
        Sat, 05 Sep 2026 09:38:33 -0700 (PDT)
Received: from smtpclient.apple (83.10.35.35.ipv4.supernova.orange.pl. [83.10.35.35])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d03635csm243336466b.7.2026.09.05.09.38.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Sep 2026 09:38:32 -0700 (PDT)
From: Norbert Szetei <norbert@doyensec.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: [PATCH net] net/sched: cls_u32: take a reference on the hash table in
 u32_change()
Message-Id: <79DB27AC-0FC0-42B2-A795-A8B585B73CFB@doyensec.com>
Date: Sat, 5 Sep 2026 18:38:20 +0200
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Cong Wang <xiyou.wangcong@gmail.com>,
 linux-kernel@vger.kernel.org
To: netdev@vger.kernel.org
X-Mailer: Apple Mail (2.3826.700.81.1.4)

u32_change() keeps the target hash table in a local variable without
taking a reference. u32_set_parms() may then drop rtnl to load an action
module, and on a failed load returns without asking the caller to
replay (-ENOENT). A concurrent RTM_DELTFILTER can free the table in
that window, and u32_change() then removes the node id it reserved from
the freed table.

Take a reference on the table across u32_set_parms(). A racing
u32_delete() then fails its refcount_dec_if_one() and returns -EBUSY
instead of freeing it.

Fixes: e7614370d6f0 ("net_sched: use idr to allocate u32 filter =
handles")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Norbert Szetei <norbert@doyensec.com>
---
Reproducer available on request.

 net/sched/cls_u32.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/sched/cls_u32.c b/net/sched/cls_u32.c
index a3e65c8cf29e..0e9128f2f33e 100644
--- a/net/sched/cls_u32.c
+++ b/net/sched/cls_u32.c
@@ -1180,8 +1180,11 @@ static int u32_change(struct net *net, struct =
sk_buff *in_skb,
 	}
 #endif
=20
+	/* u32_set_parms() may drop rtnl; keep ht alive across it */
+	refcount_inc(&ht->refcnt);
 	err =3D u32_set_parms(net, tp, n, tb, tca[TCA_RATE],
 			    flags, n->flags, extack);
+	refcount_dec(&ht->refcnt);
=20
 	u32_bind_filter(tp, n, base, tb);
=20
--=20
2.55.0

