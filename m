Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E587407CD7
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 21:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786571710; cv=pass; b=NTspp7x5hv0EcSVvcIO8trwEIXcutVFKqVZRru/4FrdneOufJS+WJWGo862pT9PunloCHHruBEqz1jWksCjnBA5RAVAIbkvOcEd501LrQ+KZF4Uq49zKGWrQ0RT5VZwRpDbywLI4QMtEnJS/3hH5Qe50yBNuqQcVeqTOwigj4to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786571710; c=relaxed/simple;
	bh=vIjMBD/ryOJQz9a5djTdptOqW89PgXFP5yged4D71wg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YBhaHi9+2TSOxYMkupxgdJGpj44S+Dy9vy1Q7auax6QMXCcZCxXMEVsEn4X9S6apF95Jy2yLs80+F4n77u4cmZlVUj3BcDjoDXXrL15/WfL2Hcojj4FlPsxVfy9NJ/lKedgry5yfHfY0blBHX/GWCuxIcOttxC4bBDV0JDsfQWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=a/rNKfxw; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="a/rNKfxw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cf52d15d88so15130225ad.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 14:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786571708; cv=none;
        d=google.com; s=arc-20260327;
        b=oIXUFj89UUn4zbvmgN9mkAG9unTbC011/M2PNTq8PkBRDtUz5Da1lSVy3isEIphetM
         3A593AMpMwU6VKpSyRHmjxc71TS5jNIfuUp3MdjUvIKGty6wwZcJd2G2DqSu+iy12uqQ
         a9awBTyhRtheTHNJXnPUtSQKtN/HKEEwHcE0iIfXxsR9oCmjQfIzIkzl/fhPAL7BSwq4
         7B+U7lGhLtqz4wsN3Cr+8wZ0hj0S0Vqyf9bxWYlpQiN0c8/r7zNzKrrjPoZ22EMlgtvV
         twgTn2kugv2G+b5wuEZ39dj1m7k8GM4KufB4KD4MOhkEERUIA4Oslpx8LmdAlZ0VPkn9
         iPmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I6Vu3XGSgx7czj6cLFodkWxMVuCPlun3Bo3kybiPxXc=;
        fh=ZSZl94MjNJo7gLGYoN7b9kSsVa8HaEh3SEWeie/z+vI=;
        b=Iyh3cINRpj2yxxi3HzKS9dK5PAeAuCfRTSzoK78dYJOBwLWwQE22TOoMVyx4pv78t/
         Tbp7zNvSNb4fehkprojHGmmOwLyObSGIOMygBf6lidB4jdFt3HayNs8eXQ5c2BDI73Vk
         guO5khp8Pl+mdnzRsT0jLocRq/f8wpdvqkZvXkFom40s5PNkfQe25SYO7+Y1H56gBS4s
         JQ71M/oDRhMxMWCiovXDW/eV4m7k8WX9G8cmij3lURxNeSQxVfYZ1SJuNIs/StRcqvIP
         wbwgGAyOkpn5L34JrPid7B2HQ881NBzl0fsKmfd+dkU7pjUh75umXvMDDicADsWzFYSn
         dRVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1786571708; x=1787176508; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I6Vu3XGSgx7czj6cLFodkWxMVuCPlun3Bo3kybiPxXc=;
        b=a/rNKfxwb0i1VIKeKwOjkaHp3mzrqx+MUETKl8b/OQbdAmS2dzdNQcC2IFvGGX2ZkU
         qusnhfZ+CpbuNPPk9/GSs0kljd0qI86poBb1xU1MYt/lELmtRFPp3Bs1y8vgOd1NGfOn
         YB0x9jrkEzhS85YSqa79FXlBS0ZxCJCnSgVkcrWodTn5ax/bU+f6W1n7Vr28++5dUyX4
         ewFHEpnao/0n7CxSD73BaiSX+WrJUAn1GvEPa+MMx+1ds55z/sth2AXk/6CvFoVRHE+K
         NXy3MdHJRPYrPvDnqwpQD9LC66a5/tg+QILFgdkioEPg4p7yH+rtmYq7STAicEzwrFPk
         p8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786571708; x=1787176508;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I6Vu3XGSgx7czj6cLFodkWxMVuCPlun3Bo3kybiPxXc=;
        b=Lae15oK34Ez0x1ImETRi8HrOm+0zJ7NEe8xeNjvB1X3NgIzl/Ksn4zHiNXWbKxhVDe
         EKiwUBp2V7F+AG9tLMA0bvR+ZlkG2LgdDSeIZSTzfkh10CglmbMPKAj9Av7ho6PRQLkX
         c4FWEUSbPrfXWNmOBfmYHyg8DpaOm175TpBDxEfwi/+u5I4Wy3mEdHs7F2fDCdG2U0MX
         lWHTsG63B7ATaa/uXlFVhvTLcibWqaJWxl1kmkOcxvmqDGnFPgSzwNtHn8Fm2sfVJMjy
         RVUfNiiD/5YRtvHXOQLxeECUVhJC2VdsTlxQuYUY4xNazszGYF+LhHYmJZLWkQKvNU1C
         FmZA==
X-Forwarded-Encrypted: i=1; AHgh+RrIp9IKfKSfbycX5wX+DgcD6ySEJDEWQ44ji3HOvr7Gb7wLc7Or4O8lZjA75lfZbkpPs6ipZUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyYmTfjCZhzJkBMNhPTSrDjVobddNtIGNmQF2SRN/DTWnFicwa
	dHmCwDuCFfXs2bJJfqK2gaFc4izHuTZnWWiJX5Y+YLpbH1LkVUTUuoyvmbFsli2MYoczzLAsE90
	S6QG+faTxBlf28nkVM5SK4vH3B9abqfVR9I1c9GRE
X-Gm-Gg: AR+sD111kMqcM/kpAz/HbE2c+1+SE5c8TJX7malJxTwhFGYEQ/jua8sMMQcyxQ7hAO/
	Q8ySkNh8QGiEWFP+PrNooEIxls9SycQ3IoOHs9xRtz/Q+lCjT63vgzbd8DPZZiF64yWIZmzgKim
	4uJNTnovKniKrrmaX6W5MCjyY5xgY3/TDnVv7al4CbRxq56S5H/K5PxchTwAr8cZXXZRu2N3Ben
	xglE7wGLwv3KG9PTMtQNFtOUi5C3GvBoQ/QIweSyjszymSgBsKkGunNDoXhPDzjGStuztNP/MDd
	JuwCoX8I8IEJpBirYmQEBuiJBXLdQwlECoHT9LCRQjN8+MI=
X-Received: by 2002:a17:902:cec1:b0:2c9:c991:6ed3 with SMTP id
 d9443c01a7336-2d37e87edebmr12096575ad.12.1786571708369; Wed, 12 Aug 2026
 14:55:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260704222254.914567-1-xmei5@asu.edu> <20260720172508.6063f433@kernel.org>
In-Reply-To: <20260720172508.6063f433@kernel.org>
From: Xiang Mei <xmei5@asu.edu>
Date: Wed, 12 Aug 2026 14:54:57 -0700
X-Gm-Features: AUfX_mxvV_cbcgjEfm3Y6LXqM2whWQqwooqXQyfMp6xmCQq4mKUgvBzgZ13FGRA
Message-ID: <CAPpSM+Ttdq=LASJ7cVQUuMs=5mrXxQnOQuweFLWhMoVnFrHfpQ@mail.gmail.com>
Subject: Re: [PATCH net] vxlan: vnifilter: enforce exact length of
 GROUP/GROUP6 attributes
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Petr Machata <petrm@nvidia.com>, Andy Roulin <aroulin@nvidia.com>, David Yang <mmyangfl@gmail.com>, 
	Kees Cook <kees@kernel.org>, Weiming Shi <bestswngs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 5:25=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat,  4 Jul 2026 15:22:54 -0700 Xiang Mei wrote:
> > The VXLAN VNI filter entry policy declares the GROUP/GROUP6 address
> > attributes as NLA_BINARY with only a maximum length, so validate_nla()
> > accepts a payload shorter than the address. The GROUP consumer reads it
> > with nla_get_in_addr(), an unconditional 4-byte load, so a short
> > attribute over-reads up to 3 bytes of uninitialised slab data, which ar=
e
> > stored into remote_ip and echoed back via RTM_GETTUNNEL, disclosing
> > kernel memory.
> >
> > Switch both entries to NLA_POLICY_EXACT_LEN() so the validator rejects
> > any GROUP/GROUP6 that is not exactly 4 / 16 bytes; a valid address is
> > always sent at full width.
>
> The netdev patch queue has overflown, if the patch is still needed
> you'll have to repost, sorry.

Thanks for the reminder. Sorry for the delayed reply. Just tested on
the latest netdev, and the patch is still needed.
I have resent with Reviewed-by: Ido Schimmel <idosch@nvidia.com>.

The resent patch:
https://lore.kernel.org/netdev/20260812215341.763123-1-xmei5@asu.edu/T/#u

Xiang
