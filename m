Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B64F39EF39
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 06:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787897265; cv=pass; b=kmcdG6gWb2m//uhu+SlHqRp4GnNwRQDRywyvV9GBdhRHS3VahlWAKcWrgjEdXFbVMw9kFzyb4eRTb4auPCKg2CkPNDSjI3+2TdCzUFPcJK4QAEpc6YxBBbU5sEzyNtDp5vDU4dSMFo+HSupsJgGiRs0Qgh4Q3zVMAvGaNf4DE0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787897265; c=relaxed/simple;
	bh=XJcCZg/vwrseqg3yh55My36FSapqIT8tQQ/7UaaNxRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qcbb5JWwLUhrcIe1me6VI2l8m+v91/peDpQDCKV9NH+bO2RM7+Cs+i9rv84bViUKmvUmpygPI/1Gc22HnDnh0Jp4eS1tieWCZUbZXYrwJTtg13jdAlmaxcMal6AMdnwNPX0ysc+c/npR4zm9GCP5RzwQJC5fd/5sEAFdMP0I7V4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sMQCONaT; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMQCONaT"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d319b84213so549455ad.1
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 23:07:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787897264; cv=none;
        d=google.com; s=arc-20260327;
        b=YWJhdUCyHVKqjOSM0NifE5GK5PwnCeTiXXw41YmFX/vTEW/7D/EtI/Tq2d4dhBLDu7
         T3oxDjD5HHHWHlZAnnEVfxjJ3djR3U5nIcAQx0bcfINjo4gkq+EQtY4Tvmd6qNUYjcWn
         G7TwD72V+w7hoJA7yF92j8b0HMNLhkMTZgR/ufl8eWSxrynPiHJ4lM2feaRTXy3BBHVo
         QpF3dtNPmxo4OwSDc6s3b44xB+OolHEuKVJQ7QSDX448raCt/QO5H+Q1/exY6WxyzAPc
         fNuq3TbvGzv3hIjZowkJKyk+K5DwOi2JZuKFmV9/EhhfVJC3unepkorfQxGqzVkxxURq
         sF/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XJcCZg/vwrseqg3yh55My36FSapqIT8tQQ/7UaaNxRI=;
        fh=tm325vvOySGNP/BgLKvRsmN3ggCIbPz6V9PXZh2dWDo=;
        b=VP4G42Llw9yuNMNAeJm3Bgpf/rTpamt9Y5K+wDyb5+3Jfd+40u5/+SLoI168MAKoKy
         BNaKYt4lrH+VdjU1Oy+rAVkx8uf2VvegTgMkJ2jz3HBh4jTc64qxGAKBJOevSl43r89+
         Vd1O1bFvLHILX0XxZS4XtDOeU4Vo4OfNnv3sxrZMLLQnzxDhNmnuEB3gw2sJbSHHe3qP
         dSGEJI+MiLPlk62l6Y0r/W833mEFQF6Z2CjA9bgNHtBKJaJB3aPrU/Ov5eWhdsxUdof7
         FCDM52lf3ZPEdDlmUygZ8MsVinSykP1CD5Jr+LKiiah/DOA09dtdZVA+cE0LxdMq5bVe
         zTnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787897264; x=1788502064; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XJcCZg/vwrseqg3yh55My36FSapqIT8tQQ/7UaaNxRI=;
        b=sMQCONaTjSW6m+MpET9Nt1FHTXp4Atvz/zy+uQ7O6WMPAAZyNYUws9em7C/fRERWWj
         ozAvGzvwdQO1TWxmVkRzIFBCv4iEIWWIt7/sFpOJNotUK/eO5OSHs75ZmHSlstyN6I03
         81JU9tzAT/6Ok2crepLWo34Q8YLe0rgIFf15S5fAWsdXWZEfT0ix3ODf1F4o/meSc9KH
         qBKCm3BKgUYHKBJ6dQAJOeDUGtWdWmgv53AoqmKKW7OkCB88h01vxeGbURQJaxuaREvc
         Sjiwmgr/Yb8ciaV/YcwDs0JZxiMo3xjQucNhDKpZC8fMbAzN9/vdzSqxMG8HJ6dhXogb
         gbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787897264; x=1788502064;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XJcCZg/vwrseqg3yh55My36FSapqIT8tQQ/7UaaNxRI=;
        b=qmzHUTAN+N8ZtNzlMxTf6YBBjMyUmBHAw1g7W+Sw9X1dWAdwuotkiDrEa+O8QrF/Kq
         24F9bGmG07EyC4i9+iNtma1obyrYile9eZ+Tca0F18HKTUInO02402UO/U3yweH7Iry+
         +lBI1xl5gkZQ4c/0bNlwob6em5uDshftKra/xiHyHWTjhj8lx/4THdD+n+oOhWAHMt9g
         b9LidyPPUVlbYmuci5GlUjyLazJkgm7C2O2DpuadPrD2xDBNHLX6k8Ow2bb6g8dgNUl8
         gO6jWrXPNFW7gU+EoTfP06Hys1w6Il/Xl1OywHWZCCXm72dsaZvixZ1epYkCGxFsmq/O
         y5kA==
X-Forwarded-Encrypted: i=1; AHgh+RpzCk66NRLxIZe1+gw+Xikc7MiNTXGfKoACYEY3AqUS1W4vR4/WJpnCE0S82mj60PCdxkHVRjQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k9uCkVY4cCOknTg54plLo/FIACG9LOr8tJvmgtozEl5RnfBKw9
	SUvLqnpmr31fhBEi2PyPvI6goKORr3jU8OnDfLBADK2e6T+t60HxlTyKj/nGT5XANhPaBoPjZ3Y
	hQOGaZRZMtm/eTLf85xHZWjxTbadmjWY=
X-Gm-Gg: AR+sD11KOI/Y2Vvn3bK0Ge9+PkN7/GM7TAa1YgrfwL+8+tJ3RdhkStQJqDJBZHKInge
	qs2sWhDCF2Z9H983nE7Wc8pMvo/dKAmUUCVAT7HLFxS3wjTEeA7DvXvuxz9ZNsOisYLpAF/x7h6
	oIuMg9QPMTy9Yp9iF+KxfYKX39qCO6nJ1s11qbxCdOv3+Pa3LhlKPbz/S5EjDDLjY2nmZ76dM7w
	0rjsds3PYB9van2rMpSBKjKTjEig8BhBNgBh15/fOlMTA+nAiMYg5awbSa+YrRaXqGuQevWHuMq
	uADH+l6OlP9oT1DpCr4sl54RRusHsbdIStpu4RulsQJ6ANQ6bcx0gAmNk7V76Pxq+qi23BabBAo
	Sft95Jp4UMuhgRUY++2p0kSY6fmgSIW8d8Kk=
X-Received: by 2002:a17:903:4b27:b0:2d5:cbd3:8eb1 with SMTP id
 d9443c01a7336-2d74df3de99mr39705555ad.3.1787897263642; Thu, 27 Aug 2026
 23:07:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
 <willemdebruijn.kernel.2ec10017f4836@gmail.com> <CAH78GvvF-mBij7exwgkthJC2puz1-1Ti=WkNr2PwFcKr_v5U4Q@mail.gmail.com>
 <willemdebruijn.kernel.361c9e585560e@gmail.com> <apDgeCLGiHTd7fAC@fedora> <willemdebruijn.kernel.3786f2ddb8b17@gmail.com>
In-Reply-To: <willemdebruijn.kernel.3786f2ddb8b17@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Fri, 28 Aug 2026 14:07:31 +0800
X-Gm-Features: AcwNN1XaaWDKqbwKCHnytMQ3rVZm_zSvGLS8Vs_yD6xeEOe67vJOUocYV7nkFHA
Message-ID: <CAH78GvtPSzvaRtph3d9j5CV+wBZNhLEuUN7bvsQVc6DmcfFY1A@mail.gmail.com>
Subject: Re: [PATCH net 1/2] bonding: reject frames with insufficient headroom
 in bond_header_create
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, jv@jvosburgh.net, jiri@resnulli.us, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, willemb@google.com, 
	netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Yeah, agreed on steady state.

One thing to flag: packet_snd snapshots dev->hard_header_len at
af_packet.c:3023 (no lock) but pushes the header at :3059 onto whatever
curr_active_slave is then. A concurrent enslave that bumps it in between
-- first non-Ethernet slave 14->24, or a bigger-header failover -- can
leave the in-flight frame short and trip skb_under_panic (oops/panic,
not silent corruption; local DoS for a privileged user).

Happy to drop v1, or hand over the create-time check if you want it closed.
