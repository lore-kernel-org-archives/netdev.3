Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBF64D5968
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158806; cv=pass; b=R+UVHMtgr16cEqJ1e8l/Z5upSr3Hjg8MLCCBQVkE2uGab3/TNSqEPXtQhzvGSdRksCGudCB8/2g4wlcmtepJgiV33ca+cnd07MVd63UAPtZfGxSchltEtFojKKxwoo/1jS/Ler/nz01Y339tx/ixHbdGGjwEDcUNquYeq9e26bE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158806; c=relaxed/simple;
	bh=cFvCifBg1Erj7yodq2VFcaiWk0MntVdZBsFvLjc5PDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jf/YLV2tLpADvOOgqMk1hEpVYIp/s7DDjC50iQtGOpvFJ/KQwpm4E10l1Og9NuzZnJRVC5uHJMwL1QJk5RqyMXU84UDhlL7ebJphen2LysJ8Ym+THZUWYVqQpbbKJSUFb2Vsw3qSpmGAitqt1+H59mM0hYUsy2OIVxZCs2/C4M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UrkPKG3T; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UrkPKG3T"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a642495d81so8680671a12.2
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:53:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792158803; cv=none;
        d=google.com; s=arc-20260327;
        b=S1AXPmZJ6rXEOKS6FDsO4T8fRBdbSUR5mcgiyERGNjXjICla4fWJ1Umv4HkYCWlhNI
         edAoBmKrjkvlYtyVzJ90K4oUxTzN9wkKYtnf98OMAiBEMVO4ND9cAVqQTzEWl9lxDT0W
         Q0ODOqTjvs5S1Ig5wV1usabe94Ll8PmQvkz7V4XmlEpgrbDAlHzwel4z4V2tyVAInspc
         rUB1MitDRUNpsQij9QMxX3KkaE+ilBJUfH7q92Of4y1hQZegdQyr14n5cztvbuxO14BS
         jbJt8QDsG5aC6DQNMs6MMrNt5RkQY8jg6+mM0NcLVf05DioChQ82iZUr/1yP0xhj2I+b
         xXMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=cFvCifBg1Erj7yodq2VFcaiWk0MntVdZBsFvLjc5PDc=;
        fh=vok9nZPDfo3Qc/l09g/irL93B13VMLwoUhGtL1dcFsQ=;
        b=qi/4O+1taD2X2iumFQjGNQAm05SKQMe9ftyiAfUsR3QafauLRdyJ4vKavcJG3RyD5/
         QgVwiox3+yZFMHRXSOpnS0yySD5ywZMlTalRCXrjbGWHgOmhE6Se3+MfhN3E625nPJwr
         boOERwLKTxSBC9rXjXeDel3/6GMxxxhJJi0SQWUm27uLOiXEft5PDglpYgt611cR4zjS
         0I6ruoo8fvR7uNHOGg/X3xOqK5QMKvDughBCmDTaeTUfCdxtkCAXiyqQVMQD48+baxMg
         S3yT+hDUaAt4pHrFQFFpeDrVPzrz6CGwgATBRgAaB6LJm9L4eSfNZ6UzhQAsa+ztzIyB
         FO9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792158803; x=1792763603; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cFvCifBg1Erj7yodq2VFcaiWk0MntVdZBsFvLjc5PDc=;
        b=UrkPKG3TQqFSqYcoBcmKc/Ou03DNJXJAbsOtE0PveJeD9h6ORhmph1PUQOAhPa4My1
         y9isF1oCV6zbjbSxteywL3yvSxO96cO0He3iGJpUx78oY3L0wzOfGe+Oi5Djzf7ww5G8
         7YEnCPTkylMB1Z1A83rpN7v5en/3m2E89NQXK5gUlDrHGeJeMGwsm2S9CUkUxuRgohTy
         90hhlMlXGnHtmxd61xwJM6Lhf++J4icKeaADsn4LJxgku0nK6AlvWF3XkYiXVrOi+RJC
         WC9f7A9zFPeP7ocSTEFsL3EzVYCrjO/yuL0xOEbqE8xTNBDmuo7kHWbz96uOEdt/OaB4
         Kgrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158803; x=1792763603;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cFvCifBg1Erj7yodq2VFcaiWk0MntVdZBsFvLjc5PDc=;
        b=sNQgPdiZ1WzPXA9tTpV7KSnZkLmF4+hdsfh5NaIYsbn1ZUCsVjB7WGNW3QAjyvjwNb
         OJBwfJxA0DPvG+1Q13F504hg4xK2LT1uOUUdkm3uVwgaN2jjnG8Qwy+Jr6sHwUbdv6Ul
         aGo0eyTiDSwTGJCrfVfd1ERuT+L51LuGI6d5ALgdPXe7j5OS18/JuMaDoVJam/PUQoE+
         r1yCQ4LTnQP5S3/CaEmp1IFrNSfm3cMg8/RQx6eKWoV0mOjqKavyIbkE9BiPJiyxisuh
         7vEd6PjgkKjtzvgzVU7JCUFQ4iSF8Ds17wFPRkAcfUp4zp32M7vfl9rlzBVNjbC2J5Qm
         chDg==
X-Forwarded-Encrypted: i=1; AKwUvBxxNkk30djPZ0I3SYB+Jy/qZTIKWWTIBv2TBKPJta3+ng1ktwvT2dKhot26GpYOa/l5qQO86Y4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLxpnDaP5V+LzIjveEaMFsJotc5Dt/Bv/ZeAx0yc2B7qDWG3LTr
	p0jhww7p8Q1KQFO49F87KSIG2iP8gn5oiEUAGy/mjdx/Cd2xVFceVCXGF4E9hFLJmiVX2BgUHMv
	CiyMpnIxlI5r1++FAODhWV+fayVuMIhQ=
X-Gm-Gg: AYBFou0KbsQhhBogIRHiECO5SX2GyiSG6iB/IwD5UdRWkg9ovuF4k4YBLNr7uOgARQC
	XtopuXfWXQ5UKE0Fg1Jhk1kmtf9HCqHmyjDQopXkm+2XrcZ14ZP2IR737Tw68sz9ZkuIjP42weS
	hmFSEFamqf6q5tyJG1eBNZYQoeyfvbssCbRzOrMA51BtyjVFqLJhr5M/rpStPjqQfksRZu1gkiF
	E9arWhNgrEq6aGVpA1UUSw1QzSuXeFqMq9jRmsB/lhruKuYlcAW8jGLuK3barV7snp+8W1gOIXC
	lixGc9U3e7nmiGg2eCZWKjk/OkLi0xxsbewvJhrK0Rd1kISobIBkmEeDcbc=
X-Received: by 2002:a17:907:3f0b:b0:c29:c079:676d with SMTP id
 a640c23a62f3a-c31a9a2d869mr2007763866b.3.1792158802842; Fri, 16 Oct 2026
 06:53:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com> <8a7eb315-b8af-45b8-a0a0-52814a5341de@yahoo.com>
In-Reply-To: <8a7eb315-b8af-45b8-a0a0-52814a5341de@yahoo.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 16 Oct 2026 10:53:07 -0300
X-Gm-Features: AclHuK_zgmTCWwlrEtDavnlWwYCxIc6oJyBMHV4DNMVoRBrUuHmo5hygFtbQTgE
Message-ID: <CAJq09z6it-Vz3cF+sJgAP1X3tcr_L3ir=iqoSduiw9XaB5FyPg@mail.gmail.com>
Subject: Re: [PATCH net-next v6 2/9] net: dsa: realtek: rtl8365mb: add chip
 family infrastructure
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Add enum rtl8365mb_family and a family member to struct
> rtl8365mb_chip_info, together with rtl8365mb_get_family() declared in a
> new rtl8365mb.h so that the VLAN code can use it too. Tag all existing
> chips as RTL8365MB_FAMILY_C.
>
> RTL8365MB_FAMILY_D is defined here but no chip uses it yet; it is needed
> by the following patches, which add family D handling for chips whose
> register layout differs from the existing ones.
>
> No functional change.
>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
