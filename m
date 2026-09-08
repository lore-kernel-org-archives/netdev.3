Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B7959C997
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788907205; cv=pass; b=sUe8BdXyKlFR+oyP4XM+XslqjZ4TNcJdjTkveC5FxCZ0xuvAbjnEjBoDCr7yXp+SjdT5JF/BrN2NmnoFZiYPJFLcToVBiqzwAqf8X+oVIylw/lVPvU3HvSluFj+QJzPDoshgbTAv/aOjWsC1oejEtJVmwc1kMuS4ombWatI0i44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788907205; c=relaxed/simple;
	bh=k6t/Fw8ETI1Ql4GedeCsAqWSetSkMzVI2uMiQi9Owxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A6kXGmrKiUlIr+l/9wbl5PDQ2uMHtCOFkvLZ9mnSOeP/QNou3nSUC4gEpIp5LZP5P/RXkMsxfrd1QVExEnp4R/YLjdoCqeyxXS+iXgDY29NJP8MY6XnjGYpHZO/JZta5VQ1vosGc19n3tATwoYvoGp6cE5SXlHSVwfW7vEgzIN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrEJ85YM; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrEJ85YM"
Received: by mail-yx2-f12.google.com with SMTP id 956f58d0204a3-66e4aae314aso449014d50.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 15:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788907198; cv=none;
        d=google.com; s=arc-20260327;
        b=FM2zhR8OX4RLlV9LtTDSaKvjVSjwt5KgsISpcU2hJtYZTL6TatPdDEWtIDB1s7JZWq
         7BHDn6CLGCzvI1SsDUVMjGNs8O0Tz+wDF6tg1P1HVm/tO3eiJTe7wjrc8l13pEAmXT2Z
         /CdnzW0p2Dv8kkEac1JiNYwGA4AlTHP7bwKhSFGHnbyT3/UfvAEVMwE1w+YhmO9Ub2hS
         6O3ecEdaBbOGRbPVKnn1+c9CaFbzh/J6VQd1QIlslA/LFM4/FjGOQzzAjnphdh/xsgl0
         dyndctI1TdiwMFH1rO8orA8x7EdVw6564HXjQTHEjYx74YIpIM2RH+dCAoXgryhZIqY3
         vcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zGSM5sEgvx57X3FTFD5DSUDNc7t7keH167lmFzFncvI=;
        fh=YW8yGu1T9go6qNa6MMDNPVoBuXiFo7PMPPMvS/PlXPw=;
        b=kAIyGkDtzJGeuO3b0E/+YGAwHubItXvbSn9wMLaCpatDcTxKilUzmaSIZyUMuYMUn+
         RZVAWemIxbycUQuuAVBJb9zYtfzwMza2YjpKjSstQq4w7zFkbsU/gIfdKRAMK15h5yXL
         f1eKVI3a5p3LvXCCzAb9E5NVoiD0nvw3fLlvJSX5RWRssSxeBLWvKuerHdV1JkPHybB9
         7Wg+lmvwuTcVXDlLD4wR3ORNtwOVNgn2KbY/ZYWHzfpgh+OlLI+PEqRyqomt8s0oO7Yp
         I+WD3fyeQD9kccrfmI1NzVP6WBdNWvcfy0Hlilav3rlbWfG73CbHGbm8EUHZs4XAaV5p
         szNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788907198; x=1789511998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zGSM5sEgvx57X3FTFD5DSUDNc7t7keH167lmFzFncvI=;
        b=IrEJ85YMbGtKAcMEtR316E9v7zIZfpM71gC91Dl/Xacy2MrgaIYhW+/sR9qZkX/sRj
         86iENTWcFdRHiz88HAmD2h9PB3Y3/ZzXHtD3SYo161oFjIYEvTB44XbdM7Myb46bSJkL
         nOP8sA/ORwF3emsaPDdxtNTyS6mZVW7ni7D6FZhmk0K4xNpIx5dsl79GCVLHsP9soUk1
         BgsUBIGi02Y5WlbW0jI1oX6KhyHB/lBmDCkVEus0Tik2IEbBmkhdoC+eJS1qLw9VxqST
         Mr/IkLEbeftahEBnv8mkAsZiNu0SJcAFe8E1OS5yti9b8N9CwXUJt4xaM0LWRAXYL9UN
         3gvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788907198; x=1789511998;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGSM5sEgvx57X3FTFD5DSUDNc7t7keH167lmFzFncvI=;
        b=d0hmaFPStosz+eUuHK0Sv49yITuTaeRymWOdY2qXk0YOE1nkhnCpBkHb9X0NkBoxtV
         ftJmt9MQfj641xBH844tM7xuVPTnJPKDC+QjvQ2ZfzRfFu8k3dQXPeCs/I5Luo8xHq/+
         uhtLWBocSR+bEulPRsNU+Ne2n8Q4T/IdPG7t5xA1D3KVyrk4vFrBT9hTmiRiVOtpUIX2
         uUiAn2ASG0rZkecUg404j/vGuhYtlFW/g3SRyAVj1LJBcj6qzID/jup163iA6l7Xbwde
         hNqoPqO8kfcJXX49WRPuCLpqYhbcde8FXNWBrItExUTCi4CDi360mWGnt+bLaI6TinDq
         dYFA==
X-Forwarded-Encrypted: i=1; AKwUvBzGxI6nq9Q7FCXeOTW4QRSvaTKm4jasd0l3pgi2ELKCNazHaWrnYABCCNIIEtCpw49c8VuNXlE=@vger.kernel.org
X-Gm-Message-State: AFuF++kHFzpX1QG1cvWum63XPALXwStxpB1BFODVw+RBk0irFhkXEcpn
	HtA0K12r1xFvlATIjdhCCkNz79se32Ff2AW5OTz6PD0V9RxALMBA3YnUbIa2eLnfjZNHQA7eVNp
	eAFTzcS07es1pU0Q0jyo5dsLRLVQPN9Th3Q==
X-Gm-Gg: AYBFou33Q+DNvL7V0Ves+z2612bOnbYojfr5hjq+8pLXswqQDPcrpKM2+cOIdzh6soh
	nuUDMCKFZwfJyUva9WiRWH75hB7bfj8/qgTTDrxPvJp6w3AnhU8ZWaZ0b9f0QxU897+oMQeisU8
	4rKKHv8U8XPAUKFm/ONo8xC7Xt1DiXBkyLDJ/HWBG1eqncnYlJmCo0ULJGuv1OqS5wAkT28SmdH
	IdmaxJCZ6NsDnc3iDCfWPNQTOB12njSIig/0HEnjtwUq3CqJAsS86eOlppx7zZG7+ct2Qdr0G8c
	8tV3o57si9sXw4scZPfYJ8MyYYWjxZF2V2hnK0r2kE+sdLuLnbdnQlbrMg7uBKIHbQTjR5OVwFv
	of3o=
X-Received: by 2002:a05:690e:1384:b0:66e:4ebb:559b with SMTP id
 956f58d0204a3-671030bb7b4mr820050d50.22.1788907198595; Tue, 08 Sep 2026
 15:39:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
 <20260902181747.2483351-2-willemdebruijn.kernel@gmail.com>
 <20260904160106.08acccb5@kernel.org> <willemdebruijn.kernel.173115664f973@gmail.com>
 <20260907161258.2b0b421d@kernel.org> <willemdebruijn.kernel.19b10eb6885cf@gmail.com>
 <CAF=yD-JSieHiaWVD9OWnFNiDaM2Y9r52S5cn=aFYYXT=DT0wmQ@mail.gmail.com> <20260908144819.16313dd9@kernel.org>
In-Reply-To: <20260908144819.16313dd9@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 8 Sep 2026 18:39:20 -0400
X-Gm-Features: AcwNN1VFPp33tnalUq7u15yAHTCFeLNyGjg-__4KcSfLVnYIzYFkyqZXrqvSALA
Message-ID: <CAF=yD-J1puTzDQUaMAsTCuCm4dYYgOzYO7S3WV6rA_pWVLKRUQ@mail.gmail.com>
Subject: Re: [PATCH net-next v8 1/6] net: rtnetlink: add pacing_offload_horizon
 attribute to net_device
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, netdev@vger.kernel.org, davem@davemloft.net, 
	pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 5:48=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue, 8 Sep 2026 16:48:03 -0400 Willem de Bruijn wrote:
> > > > From the name I suspect you mean a feature / ethtool (-k/-K) ?
> > > > That would do, but presumably not as a real low bit within
> > > > dev->features ? I guess it is a datapath feature but somehow
> > > > those bits feel too precious.
> > >
> > > Makes sense.
> > >
> > > An ethtool -K that does not use dev->features seems like a hack.
>
> It's just a way of avoiding netdev_features_t becoming larger than 64b.
> At the uAPI level we have a bitmap so we can express any number of bits.
> But in the kernel dev->features is u64 / ull so if we run out of bits
> the refactor will be rather painful.
>
> Is it really that much worse to add the support for "high feature bits"
> which don't go thru netdev_features_t to ethtool, than sprinkling extra
> one off booleans into already bloated RTM_SETLINK? Not sure.

How would this work with hw_features, wanted_features, vlan_features
and other such feature masks?

There is potentially quite a bit of logic that needs to be duplicated
for a secondary set of features. Or, the risk that these features end
up not quite like normal features.

Some device attributes, such as lltx, did get moved out of
dev->features to free up space. But key there is that they are not
user configurable.

> > > Keep the existing ip link attribute and make that settable only to
> > > zero or max_pacing_offload_horizon?
> >
> > I've updated to a simple boolean pacing_offload in ip link.
> > Let me know if you had something else specific in mind.
> >
> > +++ b/Documentation/netlink/specs/rt-link.yaml
> > @@ -1089,6 +1089,10 @@ attribute-sets:
> > +      -
> > +        name: pacing-offload
> > +        type: u8
>
> Netlink pads very value to 4B so just make it a u32

Will do.

> > +        doc: Enable EDT pacing offload (0 - disabled, 1 - enabled).
>
> > > > Not sure if we should be clearing user config or rejecting
> > > > the feature change if currently in use.
> > >
> > > We cannot reject the feature change
>
> Feature change means user requesting the feature to be disabled.
>
> > > if it's a device reset and on re-negotiation the device capability
> > > changed. E.g., from a firmware rollout.
> >
> > I added a separate patch that adds a netdevice notifier to FQ.
> > To reset offload_horizon on device feature change if needed.
> > Or any qdisc feature that depends on device state in principle.
>
> I hate both notifiers everywhere and the idea that we have to be able
> to quietly revoke device features "on firmware rollout". It leads to
> unmaintainable code which almost never runs so it's buggy half of the
> time. Whatever.

I don't like it, but firmware roll-outs that remove features
unfortunately are a real thing. Especially roll-backs.

For pacing offload specifically, I considered the risk low enough to
rely on the admin to manually revert the FQ settings when such an
event happens. But the bots kept complaining. And in fairness a
notifier based auto disable is indeed much more robust than a manual
correlated roll-out. OTOH, it is rarely exercised code in practice and
thus more prone to latent bugs.

A simpler approach for pacing offload is to check the dev fields
directly in fq. It is likely that that cacheline is warm.
