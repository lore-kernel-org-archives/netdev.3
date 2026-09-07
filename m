Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCCE356766
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763297; cv=pass; b=fUDH+23GrknBwZtJGb5fySKNziB1RSr+vXwaGzDWdE6BlXJz9WtHnYPV8EBZCc8mxkHB1igB4pWTFLoFCUW7yBjdpI/HDNQtAzQpVuEC6uUU21W96FueV9LUA7OSYfjtqAFeRNhQqXBAIsLr+k7YuHClANWyFsZc9rgkVTTqxNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763297; c=relaxed/simple;
	bh=m5m4JO08EThTXTYklbxKLzV8kne9dBNlzPsK/Alag6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMwZzYhmWSYB4C3VuSgFa9hiTYa5cyNk9PuB7+cyVr+HfxzSDMm6KkU/0/RRJ2xk5sD6trfok4SjsJu4/JI1/9l3yBfcrAPsfPXMPsSEK+owJERheYYexLfmQWiJx4xItHO/yoOQTBwbfLzKLV15bI0uidK+AXybnywdaOK9jfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uFeQn8al; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uFeQn8al"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-53069ec6e61so18861871cf.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 23:41:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788763295; cv=none;
        d=google.com; s=arc-20260327;
        b=cIjy0oC4ks5PT39FI7xIZPyhIl3DV2ZbBcFT/mrdkrghpE/TnQHRS+nRZ+sbhkfaBA
         yM3yo0v2M69+RYCekU9riQuKNiGammJRTkH1Nf8SZ0XLIkoTdScKY/SFgtXIglQD2cWL
         K2ZVblMezuc1Swn7fkSj86TCFhDOOprV2hxnPKxoDMYVKMZjUv4lD5lYuMubN70fS426
         kepEo0O405mEQquMnthSbfTQG2HwvV9N1PVR6Y7f8za8S2Rvk8Nbx2jjZ0MvLj4Gyl7d
         PA9laHTArSbCGwOj4klX/TvNYWC0NjznLgf/lH27mjKKnh2VIZ9GLJtTcTOyVmDmGEhn
         A0Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=M1ECfHkfNtF/iwj++qvEF8FxOpV8gl3x4XLc7yus438=;
        fh=9If27XZ90QB6y/08dsN8oShGP30FSJZ9Ex+HZ+3LeRQ=;
        b=fQNHMxjlYQZKVTkC4G7McT9ux0mATNkac8vqPUEaaM8VyNkP1+qmC3QzaUUalgSBaK
         aUdHIVJlcGa/Ec7TQmsucUQkf0kPq5BMZ5GLLcGC3UgUPfmO/pzhx8TjN7zaj/gnce8d
         75IazmMDjNgmXZRbxl8y4pXulIxRZbWO8QrCHtNz7wrnG6MgryvwRD9p7z2mrKUGRR/5
         DHDUPVn+0gxIf2jM+A/DQi5NPC+kTdvZtZKMjkYWKTnR2Pk7jCAsomTn1e3EeDweNb3J
         BcC0sufZEfR+nGj6ToDbT93Klnh2ELZWrcE5ex26t3uYHmhFgenBV6ED+wOo1dwNvMwh
         oEPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788763295; x=1789368095; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=M1ECfHkfNtF/iwj++qvEF8FxOpV8gl3x4XLc7yus438=;
        b=uFeQn8alJ71H8E7Ahmtq/yauFkfx3d+QDpDBLHCufN00vTV2KvkIrzkDttz+L+BdAQ
         w+tYkG0L1LHDXaSlfkb7qn3o8Ln1S/HfG7FEF8BYQaqwFs3c8fOYuZsEGNhUCIYR/KhX
         /HUTA63ZB3qMIn3+b+890U6liQCjigP/gYT/+ERfbfapoD1dipnamIEL43Usr1mZYgfb
         8OEs2qE/FSm7nctUvXcocwGBTNb1ASK1u2olfdiNMlwSvEtk0cS1ZggB9MEHSQSvfDdw
         aqyByw7ZWF1z8Ow33JJcGzDYVu2qoGrTvXvL/ESzf0V+0e860kgoF55SOYuvSVC162Fh
         2ZIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763295; x=1789368095;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M1ECfHkfNtF/iwj++qvEF8FxOpV8gl3x4XLc7yus438=;
        b=PEWgV3L8bCuFwUJU0uN244hd6u71ThcxrzFMjyj1zegzUh7R+DmKJrlgyP+O5NCxY2
         excAWgMJzhzy6YzjQPgg5/zaTVmEETGTO7pMix1OMRavxF4CWUFw3A1uBEIgj1qIIcLG
         LDpdO8WTtHfuJSaTET2LM+sQKdc6wXhxa+57Yplocbs/h3UEesWZnCG0mKipezT+sdWB
         heBWKB4+XF8jUV6bz2D7pppm4nW9njgeZV9DryHsNlg5Zvida/ma/7ydbi//i7qc+i3F
         MD5KuorQtuDJPjBxNXMC+n09Edo3JHAfCK+5F6Z0Pigl4EXHY0T+zAnXjfCj89oelkJH
         0cKA==
X-Forwarded-Encrypted: i=1; AKwUvBy6VGbZ0EvsQhJkxs2MucrfN3hDYBxm9juhzM0L8vWS0olbiCREORlBzLokMN1qUHG9oyHbJBQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mJmboCSH8zEg6DmN0O9eipDWk+iRa2CqpJ9Toa8Y4jueeiar7C
	WSb+NPw/Ne25UJo9IG/xRM6KuODL0skd11kMMht62xegHiGVNyIyJ9ZX7bC5bnEUVpPsQcReySC
	CSxDQYgywt7X4r9Y5FlYr9gaIRgBL4izkf3+29k9Q
X-Gm-Gg: AYBFou0OUjSUYTAq2IBMNyH39SwpbFT1nZOLTjaIEOLkndNEZ/J/3EZ3GS7QGSH6WHN
	NgYRCbEs+aO+5jHzZziHnPTvKrH+DSYPA+Y1f9tTpX2k1xLhU5Tzk5NpLdY7mljqNL0YNr1wkp/
	afPvhd3mz0ZkVH3C7lVW7/RDMXJ33ob0Mtl86ArrPyN97vJZRj9UC85Y93UXq2xW9Kd1QvqeUpZ
	0AefNCf5dusnj1Dwv7k2rW/JuDo0ph6umrJudt4FV3ld3XjMnjTGiPfQlmS5FgqKnAp/srRI0Nj
	nQibYkS7NzCzUcFXrYJ6eqREywewPFGEj0ADiBSWkofcpujlIyGDxpXBxv1Ak42iEcUAdhbtAG5
	nA6PZQJ8cQLqA2Y4vybXXQy8s0c+DfqxLJDJhuly97LJGaK96dMkfdilTdg==
X-Received: by 2002:a05:622a:22c7:20b0:530:8853:43ab with SMTP id
 d75a77b69052e-530885345camr20854921cf.28.1788763294233; Sun, 06 Sep 2026
 23:41:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902003344.1931843-1-edumazet@google.com> <20260902003344.1931843-4-edumazet@google.com>
 <e7060ffa-df20-4e29-b0da-184f763cdf14@linux.ibm.com>
In-Reply-To: <e7060ffa-df20-4e29-b0da-184f763cdf14@linux.ibm.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 08:41:23 +0200
X-Gm-Features: AcwNN1Xz_tpHrfh2TAEWkJFvlmqZmN5-BsvZshfWE7OPLmHhh4HN6hopDOmkgEg
Message-ID: <CANn89iKzOESmrWBt28-6_MoVioFZyP+AA-TV5U1q=GOLeUcucQ@mail.gmail.com>
Subject: Re: [PATCH net-next 03/10] ibmveth: do not assume mac header is set
 in ibmveth_start_xmit()
To: mingming cao <mmc@linux.ibm.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 7:20=E2=80=AFAM mingming cao <mmc@linux.ibm.com> wro=
te:
>
>
> On 9/1/26 5:33 PM, Eric Dumazet wrote:
> > We should not assume mac header is set in output path.
> >
> > Use skb_eth_hdr() instead of eth_hdr() to fix the issue.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > ---
> >   drivers/net/ethernet/ibm/ibmveth.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/=
ibm/ibmveth.c
> > index 73e051d26b9d8887cfed1c4168684ae199bd3108..88e8bdfbcd11293d2cc0a36=
ebea6dfffa50bcedd 100644
> > --- a/drivers/net/ethernet/ibm/ibmveth.c
> > +++ b/drivers/net/ethernet/ibm/ibmveth.c
> > @@ -1218,7 +1218,7 @@ static int ibmveth_is_packet_unsupported(struct s=
k_buff *skb,
> >       struct ethhdr *ether_header;
> >       int ret =3D 0;
> >
> > -     ether_header =3D eth_hdr(skb);
> > +     ether_header =3D skb_eth_hdr(skb);
> >
> >       if (ether_addr_equal(ether_header->h_dest, netdev->dev_addr)) {
> >               netdev_dbg(netdev, "veth doesn't support loopback packets=
, dropping packet.\n");
> Correct. mac_header is not guaranteed to be set on entry to
> ndo_start_xmit; skb->data is the stable anchor in the TX path.
>
> The RX poll path already reads the IP header check through skb->data
> after eth_type_trans(), so no parallel fix is needed there.
>
> ibmvnic has a similar issue in its TX path: build_hdr_descs_arr(),
> called from ibmvnic_xmit(), passes skb_mac_header(skb) to
> create_hdr_descs(). Is that covered in a later batch, or shall I
> send a fix?
>
> Reviewed-by: Mingming Cao <mmc@linux.ibm.com>

Series has been dropped, I will post single patches at a time.

Feel free to join the effort!
Thanks.
