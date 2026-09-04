Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C716400DE8
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 06:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788502402; cv=pass; b=NFyGBh7nKpOoK30fFHh3c7QrHDIe7lNfs6IqhKTDDUNE74ZGBEgXs5+FrIJLHreTZL0wUnvy2shTEy9rEykJfS1gnK6M2xsbbWN/VrWx9sbyjjNqsoiqTgZVUCZ7XsznI0ohU2mvEk8Bg4uPFM56GbYCGbVBZBrdTAxxDnTsNfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788502402; c=relaxed/simple;
	bh=6G07JSMGOPcEquM7UUyfzZPoJCyj32cyY6Lw03jClXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1XRaTTRoWVr1U7FQqu7IiPibcjh4h5uJrR4UOJSaZeoVt9whmW2vAECDqPBrQw2Sf/xsgFdToSynJLJBNGFXtKpVQc3y9LOkq6L46Z5uYa/waM9mvOJO/K9qprHVsADGTBchrXjRQqI5g+0JOudHtmQWPTf/CRLihx1KZVofFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bUl5OUml; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bUl5OUml"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-52f83889a93so10000721cf.2
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 23:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788502399; cv=none;
        d=google.com; s=arc-20260327;
        b=gUFisg5PCHRUZT1IhNVwWn7OpNBkCIOxkd5mG8UTYk0ChfgxtLAaYv+V/d4qbcSIHf
         ZakfzAOY/lGyBy3kUFarOPB0hbjjYyKEQUAGwv8X3Vqeh+PKm1I6T3xxgVdQZMsmAgbD
         0vNWwGNkzCkCAqwqSuRSV2ushBUTZ44VQYjdmkjE0rxsERk04Sa5pA+JEbrcHSwLTqz0
         mN1x6Mj1HOQpZj+uxc4Rzt4MOCOlZMXk8aEQptjLADWlOlTh9M7CUkqeljqDv0fpFcdP
         pf7/Bm1gYNi13GxGzARKKP5riubojN3ZAJ/+0DSEkkb8zgz26iP2QA5wryDfFxmKGVmI
         jw6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ylNRNTS7hxBes9Q2CsbYzfi2pUy/kowzYnX1kwPqjPU=;
        fh=1t8/jTSGfxj/W8ykfFXLVNgI/mSjZoFcHXy3Wq281oo=;
        b=O5mFlm4proSUKuvg37n0Rk7CNmeeqx3fe6H49kQ4PeZSLxZfJsS8gtpKmzjJXXK/dT
         T7yKPSCYS9whGVtKwNlQGpCLuwvhOAcYOoeOucF+S6yiUZT4PwnZG+NqeKyn+rSD0Ctz
         9M4X5uQ+V3VpszPrzKHLo82nSfpmc25wdjMsIzsuJkSA6wazjNcTDV4RFGxieCg/H4f3
         pn7TqcQ7Ne1aAxsnXxj2MkNywTHBihOzT/jPWdq65j24V1WEp+SWtJlaTcsnFRqxBecv
         LRVEUEVOV73aMSCRspmAbcK3oht1PGlqm3p7aIO4ftlLnCVJ4mLmYAKre6iXeURF1i/8
         xPcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788502399; x=1789107199; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ylNRNTS7hxBes9Q2CsbYzfi2pUy/kowzYnX1kwPqjPU=;
        b=bUl5OUmlfAStg2KheI9HgHjH7YIHDS5MJIvuvvUv22bQzggkGGj2hR/jTBO62BG+kf
         HBRvhCzeq2iTTVEgVoL12YdauEslJ9TCM6gvV3IPzrR2BAfSHQ3ouJqYIOf61Im8gkZr
         pdVPkG+hq9sUkACZn5CVJkAoSj1aWlGiL12xcqEmJNZJ1uadJR+pKGHzv7yMiCISdX1H
         AqibKG57GY7W0cOJ+/xOh6Y1LWlbOy0guV3y0w18wEL3F9VW5cgJFnZQMCbuogud4VpP
         Wuv5VqkSza9D7SxC1mFld17TNkCmvBASd6H1mzxn2Za9yT2kiaeYeq8UHTg0po4RSHgS
         37+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788502399; x=1789107199;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ylNRNTS7hxBes9Q2CsbYzfi2pUy/kowzYnX1kwPqjPU=;
        b=sroXm5Lyl5bURRuK6/avBBic947A2htDlpEos/nTaN2XzjjaOslDwXzg3g+VL/huSj
         aN2k9tsjVNElKbB9n3Hp9rqJmm7+H8e0cBtdZ44WntuN10ilanmllq+5DbyoqC+hyDwb
         i5NCo9F6geNXgNOCNzfTOw994pbFOM6kOoeCh2lGmxh0DWNR7tdNZFDQAQB53cyleTBM
         KFOv2yKMupLBWtCBo95Xjr/SEEaV/Je1og/5nSU5KMZ9kUGrNpajDC5ZPRGh/QiT81Pg
         a6Wj/oTlYFPnBfmryrEjSPfMcZmeEr+gjCTpfbPxVbY7dHEiAsmcaYW2EpAcQA7gSoQS
         pIZg==
X-Forwarded-Encrypted: i=1; AKwUvBwF2xoOZ762R4jfkE88oy2zlx6yw6iklnhoUCFHx1PMUZVYpTNu/O0KoQyx9DTyViI70P/ERtA=@vger.kernel.org
X-Gm-Message-State: AFuF++kPn7fsuoNOlqDfR+sBTp/UFme5uV4yFz30r09z2IAF1I8WBDN6
	1xItWngHJy/0fpZXiuFvuTCn1k0p7XZwCnEVWAaQtOOS8k+Cqfuxq3FozVVvPeBQ6NFUPMQ1MHK
	Cbay92IuIUgj1W9xsPumyZHp+eXOgHtp5RSE/NTdS
X-Gm-Gg: AYBFou3LO+AhYcTn81pzITpry0ITp9kN5CJJwgsrAxGnhF/ICw5XLhyBCLrYvF2bI9J
	KAtMrvDAOXycxw0/JGzymA5U3wmeZ2a4m9B4kv5S+4xGTERlS3ky7tiZlHoJ6YDGxQlZiFCX9YD
	JJDEkV0oeoCjP6SHIstlVTk7vL/y9w6N9Ig0c6G1GoSTbJfr2o2BFTFZTIZySfmF49z9hKRMzZn
	7QOgnzcxgG9dX4E1pTaNaBPx2pNWheSiyKb9fFeIXEIw4cOSLy36XIZsQXB/I4Yw+YRk3gMc+KA
	NSZJawmEYvaSNbPn8NG4eZvwYdmCf2RMuV67+XfebcbSsDQsgl+bb8OGu3c5vKZTv4jeHa0V8SI
	EG5wNr9pdQfGIvh8bSakRDGeKKQ8QIIcNMF8na90MTORNQ36JyoziT4LIbg==
X-Received: by 2002:ac8:5891:0:b0:530:1b1:72be with SMTP id
 d75a77b69052e-530549ea946mr41621781cf.40.1788502398746; Thu, 03 Sep 2026
 23:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904004428.1933068-1-edumazet@google.com> <f0ee0862-4e1e-4488-aa38-5f1dd5c08abc@blackwall.org>
In-Reply-To: <f0ee0862-4e1e-4488-aa38-5f1dd5c08abc@blackwall.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Sep 2026 08:13:06 +0200
X-Gm-Features: AcwNN1UzYjL7dWIJhyNSvsFDyCS8BNGT6JSbp7o-bAC6KwBabuHVGAXJwIvIMCw
Message-ID: <CANn89i+1PtnyBas8i788tR+p5uCR5tQgzh4WmMym0hAeNg1Nng@mail.gmail.com>
Subject: Re: [PATCH net] net: bridge: dynamically allocate frame_type
 instances for CFM and MRP
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	syzbot+1df7473ef265fe8ba6e1@syzkaller.appspotmail.com, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 8:02=E2=80=AFAM Nikolay Aleksandrov <razor@blackwall=
.org> wrote:
>
> On 04/09/2026 03:44, Eric Dumazet wrote:
> > struct br_frame_type contains an embedded struct hlist_node list, which
> > is linked into a bridge's per-instance br->frame_type_list via
> > br_add_frame(br, ft).
> >
> > Both cfm_frame_type and mrp_frame_type were declared as static global
> > variables. When multiple bridge devices enable CFM MEPs or MRP instance=
s
> > concurrently (e.g. across different network namespaces), they share
> > the same static global br_frame_type node.
> >
> > Calling br_add_frame() on a second bridge links the same hlist_node int=
o
> > the second bridge's frame_type_list, corrupting the first bridge's list=
.
> > Later, when br_del_frame() deletes the node from one bridge and poisons
> > its list pointers, a subsequent teardown on another bridge walks its
> > frame_type_list and dereferences the poisoned pointer in hlist_del_rcu(=
),
> > triggering a general protection fault.
> >
> > Furthermore, sharing or embedding fixed br_frame_type instances leads t=
o
> > RCU node reuse violations: if MEPs or MRP instances are repeatedly adde=
d
> > and deleted, hlist_del_rcu() unlinks the node without waiting for an RC=
U
> > grace period, and a subsequent addition immediately re-inserts and modi=
fies
> > the node while concurrent lockless readers in br_handle_frame() /
> > br_process_frame_type() may still be traversing it.
> >
> > Fix this by dynamically allocating struct br_frame_type upon registrati=
on
> > in br_add_frame() and freeing it with kfree_rcu() in br_del_frame(). Al=
so
> > ensure all registered frame types are cleaned up during bridge deletion=
 via
> > br_del_frame_all().
> >
> > Fixes: 90c628dd47ff ("net: bridge: extend the process of special frames=
")
> > Fixes: dc32cbb3dbd7 ("bridge: cfm: Kernel space implementation of CFM. =
CCM frame RX added.")
> > Reported-by: syzbot+1df7473ef265fe8ba6e1@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/6a9a137f.9266084e.bf0d7.02e3.GAE=
@google.com/
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > --
> > Cc: Nikolay Aleksandrov <razor@blackwall.org>
> > Cc: Ido Schimmel <idosch@nvidia.com>
> > ---
> >   net/bridge/br_cfm.c     | 17 +++++++++--------
> >   net/bridge/br_if.c      |  2 ++
> >   net/bridge/br_input.c   | 40 +++++++++++++++++++++++++++++++++++-----
> >   net/bridge/br_mrp.c     | 16 +++++++---------
> >   net/bridge/br_private.h |  8 ++++++--
> >   5 files changed, 59 insertions(+), 24 deletions(-)
> >
>
> Thanks Eric, but there is already a patch that should take care of this.
> A week ago I pinged the previous reporter of these issues and he posted
> an updated patch yesterday:
> https://lore.kernel.org/netdev/0345b9d5aa60ba416f6738ff1b87140f0a749cb8.1=
788417901.git.zhilinz@nebusec.ai/
>

Oh nice, their patch seems better indeed.

It's interesting that syzbot found the issue around the same time...

Thanks.

pw-bot: rejected
