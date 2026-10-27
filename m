Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793085920;
	b=34bk8iw2CdHc5Rg00/VkfoPwl388dOfQZvzNlMsAk9TUXSN+Xn3Ir3+Wt75t8D1flWke
	 bl+odf6M/t4xNBPKSdNYb/4UNvHdkGf8h8Gg1LyGByRqVjZ8BmoKCa9d16Hdvs+I5TIAS
	 +h6onDnB7aXma3Br2waR+5J23IW1BT/ThrJ636uWIcquU5+vvYzBrJZsPYcKEVVDxn1tM
	 my2xV0OUVvBANnLgFcO6mnDlVibny2z7muHWxoHrfDIb6EtskzBOI8DR4hKtEMpXZ/YsN
	 TKdlriy2BWR3Y4oKQsl+SAC1TrYKaLnghzFnAwnf4rpB/ekOt8sjehB2wbZtFpfEQQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793085920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=1b3yq9bDkj4cyY1tUi5WC5LVpuov7BX3buQ90jWR19Q=;
	b=hkxApz7WicukjV7qJ1k/Or76+PRklQCDcWy3hP0B4RHkEyvXjvk5Aaeg2ivG36BHCaWG
	 VGivlyl/48vD0IJe7bsGlLGDYn+0vNf8d6mD6SjYWMsKSOPRMmdjQihVZPwjFzmY1f2zi
	 JXd2bmxBaYOGe0oZDfCpKS+XkGxgkXmOA7LXmXv12/V/TpZkhRd93OfD2+Cdqaay4xnLz
	 c6MJAssiq6qSOKn5T8KXtOLk/H/Y1n0KbXzBLZ/bba2rRPGt/saSdYKacHa3E/vjcvQoT
	 gfoT6kPeKvKBaXALPV/NFW4hPNsONKnQDg4zDLUdlR8DzqbPUn9Is0uRmeZ6U3ZSmhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=i4yqr7Tm;
	arc=fail smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FDC2606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FDC2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=i4yqr7Tm
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a06b44bd01so2046480b3a.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 00:25:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793085919; cv=none;
        d=google.com; s=arc-20260327;
        b=on+PktJ3zA++ri/Q+pyRaDp4JNw4T40xL6xq0bFCZMdHfkHXP9WhWtvmgRyq7gga4f
         myrwNaOfCBWAjppjrCBfOCwjzuhiGcCpqROTgYbpB6xdKgZONM0072EzGTN5hEYmtCxy
         zmi05SpprThjM6GvjnPBU5WbC6DbIhRN+ApIjLJ1+tVLz1ri+7T6dg+6XuYWv2PB3Gna
         MivbXgnYLkRpekchQmb4wX+6fo4yTw7W2YUQdexcYSle+u9plsx7OWxyc4GX2W5Y0yLB
         3k7JPs+fbsG/yNYsifoQ+sJCG5v9HcWSJBAaDzGHP21k2mvwnVHXyVi2kLn8lttszvZu
         47MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1b3yq9bDkj4cyY1tUi5WC5LVpuov7BX3buQ90jWR19Q=;
        fh=iAJC7kS9UjHmc+Sjy1lq7MYljLB6+FgcWry/g9bbxxY=;
        b=LWGvIiCPz8siX/Vd7dexj/saA6hrXAFJAKyEmyP6UN/fGek8wuEnBaxNJU+7mXud0r
         zty13DEHnWRc5AFJ5X/4q7CFNZnlrsQiqkMB/twTXyk6gu7c5A57H+29nlVaS/aXBFoI
         3DebYj7DRxnNJOhVvHiknsdoABaRV7ferE9OCVnY4aGXjjOzTl3EhjmcHjh8kU6c/70/
         MJVu66ppi26n0QpXFjrR2rRk6/TX7WRH1w9NvhgXll2mT+GzanTTmlZ5pKjkkJa6OxIJ
         rNwF5gKIokDgKv97XW0898cdh3BixNeJ6DWXUCcfSn5eVi4f1X/5XXSpZ5rfjJ+uXXxZ
         Hmiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793085919; x=1793690719; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1b3yq9bDkj4cyY1tUi5WC5LVpuov7BX3buQ90jWR19Q=;
        b=i4yqr7TmR4nmOslL8RUixlCjBdWDnhnOn8mTXO0eJbWngP2C6b/ZZD1XVhWpDnOvd8
         C2qCLaFFSLRoLZZt/nXpQUBmikFS0ckpGKluZRI17EGPDMlY8n6iyVnwDjsgB2qwlpZh
         tSwWOHo5j/ZLYmvp1EIi6dYs5Ugfz2oOSiUNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793085919; x=1793690719;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1b3yq9bDkj4cyY1tUi5WC5LVpuov7BX3buQ90jWR19Q=;
        b=gICaXjQ6CXFiguqfPUI0zmsVNzjHsqbmQZ71naKvi8odLAPCEFOkeVW+n3xSIEz5/6
         QgOT2zmEUmryRAfIhM7EPKT/d5k1K2T5g60jQjS0SDCo0X29E+lqi79bC3ZfMxrI/jFb
         6h0Dy+rh5/hvqvyL+xK3TJ9TI3lmpxzu8ypSW6yrJEie8eaJd/R60FHQ60qkFeCq0zVC
         +wNPpf6CaSGF628DY63lUpQ2WUcMeeo1gK5afj4LPOcYIe8J4pJcFGr3Kbcl5FNJdjix
         V+4Z81Zq+ekYKE6jZOpHwdZ3NILPFy0eWw6zZS6t8i0al6H9X31o7ClqYqBKKL3VX+ke
         MKUw==
X-Forwarded-Encrypted: i=1; AKwUvBykTBO5NebnnxwJzlRVye47mD6cYjLcIWWkXGVBexKgnTobAZuNJHMR83fsp6DX1tAAe3EUGqE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxFLfAdDgROEPBF0ypfvaNuR+dl3HUjHyZMRyAsBBgz6IxmctJ
	nhatrmKjwNUILpOMBHpO5xJfaJw1NJzdlEvxydVnANHpij5J/6rn6F/WEDAHNByqffTwx+mQyJM
	+7JmIz98cYdKH1mQNLBhFNuOl9g5mP5pxs9CQVQNt
X-Gm-Gg: AYBFou0rm3gsJKnOqZ1A51k+e5g2v9CnJRxfcM2WhyBhHpU7YNK9+PSkpalE+Ijoo1n
	hnye4Kes5+lalMYTNUUipitKL+sc+rI3WMnoyIFwV+uAdsnNtXiYVAJDP9F7qvln0yKXCPyfo8/
	TTy7Jr5RVjjy7t/+3Sf8dKYKWmUCm4DubJcxNmf/nTFeq83IJIjMYszKoclZ3v/alFo8wyoObj0
	xPGXullM9h5sK1xx2kYtzcMSZw00V6T15iuFTIGr+iNjA4Ob1iSR40Yqh4MnAmcmaW5lhW32x+Y
	Cv2dUsig44HK8efwd3Tiieq5XvrIZBSWkduIc6PG5zPLYNWqA2GoNS1NH4z1UwhselNhbxdUokq
	23LEeuA0Uekn1lMv0AizzXPl+HVk2/wStk75UwvTxcyaLUIlD21uEx/q3iTC+h1VTs40KZAEkTS
	2jaYRhXeGubeMI0b0=
X-Received: by 2002:a05:6a00:9093:b0:878:3783:8a88 with SMTP id
 d2e1a72fcca58-8a3689a9e0amr7511811b3a.52.1793085919500; Tue, 27 Oct 2026
 00:25:19 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <QDISC-6HS9.v1.r2.20261020051718-2@mojatatu.com>
 <20261026160747.283702-1-horms@kernel.org> <CAM0EoMm9piw8gLJ=t9YYNu2-8zb=qfA3G6djchL0QaeZZvaNfA@mail.gmail.com>
 <20261026174643.088e3f49@kernel.org>
In-Reply-To: <20261026174643.088e3f49@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 03:25:07 -0400
X-Gm-Features: AclHuK_uYZ49I43utjW4TiugqfGvmoGuDzSGM3UY8eQ0cCU3DR7mRFC8rpStjeI
Message-ID: <CAM0EoMmVv5WnzpQw2d7iLZU84KPDUMf7+t5m8BL+MBXR+oy7Lw@mail.gmail.com>
Subject: Re: [PATCH net 2/2 repost2] net/sched: sch_teql: keep skb->dev
 consistent on the arp-queue path
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, victor@mojatatu.com, 
	jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, sashiko-bot@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 8:46=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 26 Oct 2026 19:51:33 -0400 Jamal Hadi Salim wrote:
> > > This is an AI-generated review of your patch. The human sending this
> > > email says "Hi Jamal, passing this on for your consideration as it
> > > seems to have got stuck somewhere."
> >
> > There was nothing wrong with the headers this time - so not sure what
> > is going on. A bit frustrating.
>
> It is frustrating, you are the only one with these issues.
> Patch 2 is posted in reply to patch 1. IDK what else is wrong.
>

Let me send a repost3 - will take the opportunity to pedantically fix
the commit message (no code change).

cheers,
jamal
