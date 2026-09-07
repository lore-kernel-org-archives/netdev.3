Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94033A875F
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788792146; cv=pass; b=Q0oMHDz+xoDKpAq5NMGEvjZG8LuiB8t/55fNDUrpYe6fDTaOv8pcEqwvqA3y1HTB0QttapPJ1KfemVb7Rj56Wpked1tfnzesikPYElYxobPPNNkOGq6tJxpxBJ8RjS0oo9AWTthU2O6be8Mk6PYE7XbuceQYr0p9kKpw4uGb4Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788792146; c=relaxed/simple;
	bh=CsTidLUG0CLTgjErnlm8+OqDENBUP1sGkwcCgpK05F4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uz7xXYExCEJ/ZP1g8MgQaiRlkz8ciV2d0RSJdKWs1y9bRe01JUAtyOzkjx1uAd/0Qi+Ilszi1lxGxAMXXIoYqRfzgrXMH9miDSgSxX1V8GvTrDrKDY6eT2oVzx6o5IsBTp3xBuuDSBxzwXWDbYaD0Q2xWUiKmRuchRRCLH4F7qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLuX3W+y; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLuX3W+y"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-52ff0eea420so37906931cf.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 07:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788792143; cv=none;
        d=google.com; s=arc-20260327;
        b=g2dACxP0orv/HaMqy4QX0o3mdJVzRLizw7isTSUvq3Oo+TKGUJdAlTVTvUes9dqgIo
         iPqQdzTAssSJVHM1TajhMYBaeZ0IJgvtptfUTvZhqNSrouEKcH+U2DGuUG3czCmiBrtc
         t1/AtABbx6U0LUZ2byc01s6Ci3nEUwgAT7Ujo5HIQ6maz872XDrl9aTlTIJGL0EKZFFG
         ofq5zvQDqjH0HJNWEvllut92xiUxV0H5dl7++i7kXFwqDXN2xxIUw578eUM6NgJ9d0ed
         Sj3juDpcdy42UDTwGc/+qC0ylNpcK3uDuSAurN2bMvi5HsuZwOogLlKl9/furw6NXSVN
         vr0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CsTidLUG0CLTgjErnlm8+OqDENBUP1sGkwcCgpK05F4=;
        fh=dcG4sbbhie4O3KJTDio2yAwsNQH+AO17jP4WfmG5eOw=;
        b=gM1HlVHnKo0FK56+l5MolrFr9PGsita0noNiAXjqfIxeCXlNxOF7wRxOXbO1bzqheJ
         hxu2X/FDfU+OTykpq1V0zKuE3dKRbVl6QQT9V/Na6+nLLxKnWvsiwlISzmZDJmlgcENH
         9lWwe5SVDgJp+uN/iqRWRzIIdNpYaGAjh4olTY+/6Z8sY4HZ2z+3beAV0DxrYSltyN62
         wwa393GHnbyC4Nha5cCfesTdLcACd2E3y/NNAbX+8oodIdk6EtwMi/Q9NlxLWZGSlCun
         dmhVBC34JoPanhfxvtkrHLkOsI8NtFdQRH+/Xh0ZUQTI2oFENuhlGUYKu3ibCh6yPjFb
         U0Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788792143; x=1789396943; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CsTidLUG0CLTgjErnlm8+OqDENBUP1sGkwcCgpK05F4=;
        b=hLuX3W+yWx6zUvE5wnct4H873smNWVkfo2AIWWd4KTQpX1caHkRd4LTpshhQX2JoAd
         mo7vfa58y/yHTcqsK20Up0GvhW1t83rfj1/bUVqcFJJgcpUQm91eTeiBoEaghucI73mr
         DwzvMacgOsVZoCotaSBXCmCmQNznfIwxcKAPyAM+LmXOVutyhncISb8N6QM4Cmji9++e
         Vejs259lVq++SNMHxUH2suJkv2IAxUoppKwd3LAx6QyzmTWupqeqFOaAIZqwM1QYHify
         9Phvp5HByLHjehBGpTaUYM2iABXQDPuIaTLiqOI0ZEfUyBCSxaPZ4LBYC1u0umJhygV4
         zSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788792143; x=1789396943;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CsTidLUG0CLTgjErnlm8+OqDENBUP1sGkwcCgpK05F4=;
        b=jIQIOq48XIDC/SWraW28H6saUvuaqGysg8nv/Wc5YISiXt6orZxRV/yp1O9+egJSsw
         qLQrkQeod5x0Vh7yxCoYaRjvqmx8vLwBKtarYR2ZapQUBkHhek8vtHanmzeMgcdwEJo2
         OKuYVYEdMQnR0B3q6cX0V/Xd7bNHzkePXkCYkCt+MfRGtRVVPiHbG2Rr1zlUUEljqxCc
         XK+7DDn8WEokYtKnhSr00YI8ezleajc5Z5I7lepmDCxgeaDAq5EBwxk8WVXA8swgCZBT
         mNylBVm3U49lc7usQ9TD02BtGwZzeJZ2Qozm53spI7iWAOntoUfpCiVfW8KVR5Tl8P41
         ATug==
X-Forwarded-Encrypted: i=1; AKwUvByDY6mjBsjAsJZiEhTPZQ0yO5Fl56cgqfScXSLQ/+lk+yt+52Ue3Mw2BTjq+wn1Z6NvifzzCOc=@vger.kernel.org
X-Gm-Message-State: AFuF++mKaneCjaAufAkSUuKarYBYfQsvG+sBtDR+XdN3VzBN9/XY3Loc
	3aDcQW6xll8H4oEraF10mAo/iprWbRgnCtyycV4cRMeIbXvPpha+b3s/TDGXN6tmjCEZ7suYaB+
	1NFkd8p58Pvlh1T4oFbc4p9V1tdVe2h9Zie5AnUNs
X-Gm-Gg: AYBFou373mdImbjItihkCkbyikFhKBW0HYlvlnKpTgTKX/ruhXzOp2Up5gv6rve0o57
	1itcd1pUEqVjaLZZ0hyM5wjQjHZd9fFRRf1dQ3YxaoBoz4Dbc9WPLBn5cOJb6ojTqgjOjC5/ICc
	Y5kGoNmvleoxKj/zwGKYCcCNnofxJBDaVysq7sis2FYEhPnKoA62ZhT/NbuhqhhisGpmUvgL4tX
	w+CBg4Huf2g9pv8hJfdLIVcmwgYSuqIOTehYGLnZTv6wsp2Bw7LQ92PnCdpxG1yFOBT4sjf/mEi
	3IjBCBQyJoJbFLFXzBS31yDt4biZuy4mRq2DzLlw3c4w7raJJuhMwlSqhqZQwowWfHB0UhL92Ft
	snxDmgkxhxkchiItdv09M+UtvsYmHe58e2BVPi2k29xuFWVrMB+piHteuwg==
X-Received: by 2002:a05:622a:181c:b0:530:4773:1139 with SMTP id
 d75a77b69052e-530477313damr240525321cf.23.1788792142504; Mon, 07 Sep 2026
 07:42:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907075846.2913645-1-edumazet@google.com> <20260907075846.2913645-9-edumazet@google.com>
 <ap7LFmE1Ykohf-eM@lore-desk>
In-Reply-To: <ap7LFmE1Ykohf-eM@lore-desk>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 7 Sep 2026 16:42:11 +0200
X-Gm-Features: AcwNN1Vm90Ick5u_RE-85bmKCHDAHVRCL0SV2bTzq8Q56FEg6VyPh2P-y87bw4U
Message-ID: <CANn89i+tmdCextmwm9zWCODWNQkCLFE2x+wrAJmcgrGmEMFTKA@mail.gmail.com>
Subject: Re: [PATCH net-next 8/9] sit: convert configuration to RCU protection
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Ido Schimmel <idosch@nvidia.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Artem Lytkin <iprintercanon@gmail.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 7, 2026 at 4:33=E2=80=AFPM Lorenzo Bianconi
<lorenzo.bianconi@oss.qualcomm.com> wrote:
>
> > Now that SIT parameters are dynamically allocated, convert
> > tunnel->sit_parms to an RCU-protected pointer.
> >
> > Updates in ipip6_tunnel_update() allocate a new parameter block,
> > publish it using rcu_assign_pointer(), and free the old one
> > via kfree_rcu().
> >
> > We only need to unlink and re-link the tunnel in the hash table
> > if either saddr or daddr changed. When neither address changes,
> > the unhash/re-hash and synchronize_net() can be completely skipped.
> >
> > Readers in ipip6_tunnel_lookup(), ipip6_tunnel_xmit(), ipip6_err(),
> > and ipip6_rcv() now safely dereference tunnel->sit_parms under RCU.
>
> I think this patch is fine, I am just wondering if we can use more generi=
c name
> with respect to 'sit_parms' since I guess we have the same issue for IPIP=
 and
> IP6IP6 tunnels. Do you prefer to have dedicated pointers for them?

Name could be more generic indeed.

I was thinking of using a union for future tunnel conversions.

>
> Acked-by: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
>
> Regards,
> Lorenzo
