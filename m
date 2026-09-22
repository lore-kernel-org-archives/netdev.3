Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9355295B
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 14:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790087001; cv=pass; b=nc7czKgJP2pfVrzjTaZd4pknRaXgptSHxHETCWS8CsRlzZuCATECSLneUatrE1bESs1G26a+ouLMWaM/GO77Zq1bud0wEwz3QsHytu1VOgl3usErJde3FFFYq6C+VpJT8LSRBEvzd/cKSXWWUJO77vYWxexML5zCy1/2vIr9D0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790087001; c=relaxed/simple;
	bh=/sRjoFYt9athMMteByZShlOekmvjCMXNM7jbR3+jJgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pbq0opxBAswxvcAZLsEfYcig92CycVMDrD5C9Xvvju+W6sWNk3t/nf2dx9PaEpO1RCpEGiWKLZxNs1I3n4nBmZL3lUiLv6DEda2ITKjRd/6tU6Fb/3yQgZDex2nC39vnMnDJpisDNHyPeuZNWO/k5RLsX3O0nLpA7p/ml3vHsNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tj8tlYuU; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tj8tlYuU"
Received: by mail-vs2-f12.google.com with SMTP id 71dfb90a1353d-5c67e5292fdso1543636e0c.3
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 07:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790086999; cv=none;
        d=google.com; s=arc-20260327;
        b=DaeLcFGAA3c8xXLI9esGb2fEOjES75JdBYvW88cE/7uz+66yfbT9XXRh2I2nDzCK6o
         Vigj83TKi0poccie0Z+3Usv/I0wcfODURNN3aahQnSF466G384iD2NXr9eNI9VFfRmqw
         z5Yo5QTXH6whdYA+6Wrj1uSoMoSAWMlnoDXQTtTjxVkf5DC3u/8/94VSg4fAtkv27zUt
         OWtdB2lzrt4YfjpPF6BOjb6paWovJhgpUfu1YCzyEWzoJ9nEjVhuYwgSa693Pk5A2u33
         GmGa8U1BIlauzct1ZaFmb+h0hJV0CLy7NHVoHzsGlLfhTugkNw0dPXPY+yRQIPUi0nW6
         l7pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Oxbt+XZDS8JEW25sB7UbDhBj24R1C9rPNO1Jj96pTgE=;
        fh=vvQtwl+vrZVaorDYR6AwJaMmzEAbtiSGzcj23g25lIs=;
        b=iiRnLJK2VrmPRGnJ2t1NqEL9Shhvv6SAU/e0wTIsiIgCVuV2QfAmWkrkX8Hcf6Y/pc
         qusGkNsNYPwbmtrEHFRPLBi9vokf4nMtxbPfAWDf3jpXkQXi9Aeg1V0bi8ElMHx4KdM7
         O7rnFFO4jytU7SHvxo6WH7dhlNVMTfaVvRXgd2hvg98sNPJXU2Xcpw1K5+imPkq+MVc0
         S5s1mYH/dnfbSITqwMjie/Du2z5Pm1xKNZxMKUzISLKpYL6lxmwVoAvCwftaVulwKZDx
         Ppnf/r7l6WLoWuqm/GaMV9CfMA4PCB6og2FBnlG3wDBfX3PfoAundwkcWu1ZMFuQs0dC
         OSbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790086999; x=1790691799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Oxbt+XZDS8JEW25sB7UbDhBj24R1C9rPNO1Jj96pTgE=;
        b=Tj8tlYuUIF6oTv4GUmpmFCnttHkGr2EyYvfeVuh3k7/lCEQBpD3rnuhMMOuz699bph
         2i/sjYHdff+0yYnLvugcHK/RUr17on2tFglzunKOnuYyMYhEXbOxb5tPolHUMqEBt6LM
         xTb4Ha8ouDh7QhciM37mKV1JWS2W80tujh+IPZU2xPZLmt7ZvavAy1sGhDE5MrVde9jg
         YOIMKGzfDI0Bq4X8H8K59OqBmCtzmVOj3+a7tTNSdjOIcWwnr4sQwzQ4Nh0YppoMOenM
         QbjT1LntDUqY6TAlMGb6dJFESjFGc6mj9OZOWBCapoYB4YOpR/W31dtqcVzr8+brASlc
         0qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790086999; x=1790691799;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Oxbt+XZDS8JEW25sB7UbDhBj24R1C9rPNO1Jj96pTgE=;
        b=eJTUAXrtR2KbBYbyRx2ABathsmifFJCkX3rK3pPD+IYhRJf3Ip8+/jgm0XG++dVdmd
         hJNtMh/bqtmmADrfDw3pQZD6vG8XQG5sfWiNIaG3n+Y70LTUptLRpbKB7HRY1Waa4gc1
         NpaYMewuF56BMZRcJ/7cM68D9D1oMCK9xT0hRuc/3uvZ8eRaRzZ7pbzACKdBH0D0tCLG
         VehR6DsIuO3EQ53lwDv3YCx6ZC/WCxeOb5oKJRVxTEldp5XcEHoGgMZ4ouvX1gBaAAqt
         gVuTsa+8a27HHFLztYMYB2cp7jH6d4zpSLEQmvM2JqMJHVESgCpUBXfzf2OAqZN+RpvR
         XSDA==
X-Forwarded-Encrypted: i=1; AKwUvBzmw7IZEUwW3PdMVA+zILChyYVtAGGete3PABBNwdgGmSE85Ywu7+OfUICBDan7ilPi4LzMUy8=@vger.kernel.org
X-Gm-Message-State: AFuF++n0e58IlwgwwV3Lu2LHk5cJO7+NChYcMU6Kz78fb9FGi8FH+n02
	+lo5sgA7HK6LZZ0KlnY+97RnbPWt0tadqwhYPBDZPFpbJkIM0ncrDfx0JjAuXgdpLpmEr9ulLCQ
	YNm0Gp5xyktc6iNBzHtwh+1Mscgo8QzdIhjGQQOA1
X-Gm-Gg: AYBFou3p9kt7NKCoh+fR9CGfD+z9YCn2ueGGSorvhqkUv6f82filcYom/aCaCHovcYo
	9quNFwuSECWHwIEoQhO86tolxTgYyPM8OU1rznuOjVVPx31fuD8wIvTakRNIYl+/Yy/qB/3dzMw
	U6eido61FrgaSuT1VAvL9KbYkOQGk8K/VcjiVdsQG+nv+xkc3LNnfAs8zoH140MsWa/6HTZxrkm
	NixhDYFAp/EBCdjmRMeqn0zpKCcHaVfzkCIhLyrlyjo3rpoVQmFITsAMofoNWA8JZzRBxroAbut
	vVBD+p2TVdHve+kp6SXhvvaNMVJxSGG1gDwv3+OtedU5LqTQfc8d57DhMrO8bUC1a0D6FkZ+kxk
	/dGeSaek22MVIou6CHDqQ6O9eHSB8M1+sXMIKKndQMvZk7jfz/B8rp5uXe3qdrh3Cop7+ZA==
X-Received: by 2002:a05:6122:390a:b0:5c1:781:7122 with SMTP id
 71dfb90a1353d-5c9b58f8e64mr7111747e0c.3.1790086998349; Tue, 22 Sep 2026
 07:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922131239.2509494-1-idosch@nvidia.com> <71792738-39d6-4375-9d47-bc4944727ed8@kernel.org>
In-Reply-To: <71792738-39d6-4375-9d47-bc4944727ed8@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 22 Sep 2026 16:23:07 +0200
X-Gm-Features: AcwNN1UMtVoiQovfWbxs9eRuIvoDcDqx6yUEURZpfyCzvdBRO3YYprx6pNn4xgQ
Message-ID: <CANn89iJdt9ON-GgnRCHNAVeAEniXGCcfGWo0YMNSB=HhB68-yg@mail.gmail.com>
Subject: Re: [PATCH net] vrf: Stop corrupting skb->csum when capturing
 CHECKSUM_COMPLETE packets
To: David Ahern <dsahern@kernel.org>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, 
	andrea.mayer@uniroma2.it, stesasso@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 3:55=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 9/22/26 7:12 AM, Ido Schimmel wrote:
> > The VRF device is an Ethernet device but it can have non-Ethernet ports
> > such as IP tunnels. Before the cited commit, capturing packets from suc=
h
> > ports on the VRF device resulted in these packets being detected as
> > malformed since they lack an Ethernet header.
> >
> > The cited commit fixed it by pushing a dummy Ethernet header to such
> > packets before the capture and pulling it afterwards. In the case of
> > CHECKSUM_COMPLETE packets it also updated skb->csum with the checksum o=
f
> > the dummy Ethernet header. This is wrong as skb->csum should not includ=
e
> > the checksum of the Ethernet header ("checksum of the _whole_ packet as
> > seen by netif_rx()").
> >
> > This also means that L4 protocols receive a corrupted skb->csum and
> > potentially drop the packet, as is the case with UDP packets whose
> > checksum was completed by software.
> >
> > Fix by removing the unnecessary call to skb_postpush_rcsum().
> >
> > Fixes: 048939088220 ("vrf: add mac header for tunneled packets when sni=
ffer is attached")
> > Reported-by: Stefano Sasso <stesasso@gmail.com>
> > Closes: https://lore.kernel.org/netdev/CALtE316UtL3x7LL6uxfXzx8rW6AbzYP=
eDOb478hqJCr_-dj=3DWg@mail.gmail.com/
> > Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> > ---
> >  drivers/net/vrf.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
>
> Reviewed-by: David Ahern <dsahern@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>
