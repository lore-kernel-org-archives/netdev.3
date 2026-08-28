Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAA8332EAE
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787929063; cv=pass; b=hEHuEwJIhSIyNr7hEkgkdH7fO4O5CSZsosct7bplED6tkC/b3w1vJr4d91HK/G470aNSBuNbTaExfj9Qr298jCM9+9QD4ymNdgLcxnJwrea1UCepq4IO2D6/2DUemuHV4PRUmg+b/Ml2hA1Pfg7CVqRs+5lCGI9irqpPt+0pXGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787929063; c=relaxed/simple;
	bh=kAyeEhSjNccNcnTFgFj7n9DSA0wrFShWyms0f0y15AY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nEn/+Ry4jtElOtevyU9Xr7q3rxIUEOVFPfwTr20gpiGQvReq0JLpuot/iBr11JImFMPRhE8ARC6+ThUF0yB4Um6uvwX7rRjoNDGVksX1zF1d+YFWSxE+/GyauXNK/jkJA32jII6miDHZXo8LJobWbCTZJJlZwl9yXVdptwHwKiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uSg/N1iS; arc=pass smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uSg/N1iS"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-52d5bfa4bafso11979651cf.3
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 07:57:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787929059; cv=none;
        d=google.com; s=arc-20260327;
        b=PGdEuYAgk3w/MIGOwYf3vFKXPcknw1aRfVQ5gsXeq3zEuBDNKZVbqfbEd87sBchx8p
         E5hv3P/m3yOC85PNkROvyZRhdXOg1DQu0zHn9Cv5alqgfIMc59a/zFurumEQUceKibxQ
         JM8ChUnX/FY3abyCCLkqvGnBLdHZ5i3OSkzdqTJtbOynHFnVrW2arG1jMooxBxrQ2d2W
         FkuU3wSIRhuxbzDxhAqxhhsUS3+yosNlFGsmWcd/vojw82rHmdhRjN17g40re55oQF9W
         lW09wLUw1e4SAnr/28lbw0YqVZAvU8v+MO/yHvcGEWQeZwXX+CgpsowuV/iW6cGQxA8l
         Xpug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kAyeEhSjNccNcnTFgFj7n9DSA0wrFShWyms0f0y15AY=;
        fh=YQHQCn8cHHo5gGiyoLTOPbMDn51NtEsz3Gd3SfGYj0k=;
        b=XjEe1MiSLYxC0MoNE+aOKMGR11r2SU33eCVCmp0q54l4AhYAPNvmuvfAx1G358Fo0/
         7JCm/rdm5HPNG0Nu0/FreZihEkQqVAXbx6hwbxAClBuiAerCNvBWZ76jy53VGGZmXeBY
         tAl/Ja788Ts2zQQJdW4sppHGtLaGrbQaDnT+XJDMSMuMAvRlDukGGmMVYoxfim+IJ23y
         pbiHHIbWNqTnwl/dT2w/nnUTLc2VPUxL85VGuMDdH/lHFIGgnAAeXDh2+5pxV86UVIGI
         1A4FpJRahu1ZUIoLhJotjqvpoAHG9+rEbcTJGFFzvLXyvKk6Im2aImWjZ8JMaegNwP2a
         qqmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787929059; x=1788533859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kAyeEhSjNccNcnTFgFj7n9DSA0wrFShWyms0f0y15AY=;
        b=uSg/N1iS9wRCLSsaEb5RIKeZW6B1H07+sjbyyMr7O6RyDSp6qcgD9gGPwKE8fkXcW+
         wCy2Sby5T+FoRqJZmVcZVIEl/UWrxrHG5yrCXHR3enIVXI6RIDwDKz7geaIx8LfzJ4tf
         MPU9b1K2TUG5oFg3i/aKQt67q4Mr+hNaGgruUh/dgo95iRtN7th41rv01tEewQgnAICI
         vHVfHjfD6GMeuclYPtxIsn0lBAwh4StJwePMr06+NBmJp7nwMYPR8irKqToaySbYqOOU
         +//iUnCtw87PflVAXOAJ21UI07sKgulVqLgtFe7WHhf4opRFRcL2jkD3y2027K0iwc8K
         10tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787929059; x=1788533859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAyeEhSjNccNcnTFgFj7n9DSA0wrFShWyms0f0y15AY=;
        b=YKmL3qgvxfRtHZYdPdw5/KoVCr8F1xKULF1cEDxz7zcuZcW5aZE/O3jo4FS6aaqv/+
         OpWKM7Up9gKIJHwoVKBSK12sMex4d6COZvtNDgAtWoSMMXxua2rZBGkFuIEw+XyqRLUl
         1KvlzIsViKh5VrzGp/H7LfA8BlOyDuFsccbd7x8guvJZqHjbDsz2IVICbM4fCTDxXwf7
         +rVoM4+Y8soDHFihsM4Zu5EJgN5mNya/10Qsf+cqOPMolvWEL+VrldsJ0/UEN3KrKqkx
         05U72LDEixNODN1qI1BiHPJIqk4OluK4IjESOaEit0ggYiqt96oybelcvEgUTJaWnKBH
         nh5w==
X-Gm-Message-State: AFuF++lwwzAup6oBGqZ7pUS7j5HIRlE59DraxOTgFczah6TtV2z2YG5W
	kFfYd9KyB92kgtEznayPg+qJZn9ClqyO8tXPKPS+u/bpRiScoIY6g2azcP7+u0mq5vw5sRHtH92
	h6wpqzklfyRS/PuzcTujgDR4fUjDl/E7CzD3MZg+F
X-Gm-Gg: AR+sD12dxEqESPH8mxsM2pdrxjlHQi9fZ4L15LfQOPnKOUGxkv06oOUJVOFeaRA1gpy
	/JPFvbue45QjJqrgg1oupqzPDjir33A3QK5uZGbA4mDxOT0b9y7POQV+x8Bv5MwkP4lwpGVITVF
	D7OB6Y2aUeI7kjfy8tmGtC1hK8022SxRyZw58atboJr8iJLJF4upujEPNAnvG310LnnLUyKmVU6
	Ic8dz1EVDP4L2USfistAnwCFnFSX6WIc09pzWmXM88xaiOVn0j8IRWz+EPe5sdQziCU0w1V3rVW
	SEJB16BIDfd6zD5Nr4RHNfz15dzojehhMqgYBIb1gAodUHLXxO1NV+8SFBQJwSIrCrQoYMETZjk
	n4mqat0DYecghcMc4CVM4or5cdCG9b2kVuamaONZM0/nE8c3ic1nuIe7JJs82JIZmZg5szg==
X-Received: by 2002:a05:622a:58c:b0:52f:b36e:4075 with SMTP id
 d75a77b69052e-52fb93b2b20mr87332321cf.10.1787929058786; Fri, 28 Aug 2026
 07:57:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827230233.94878-1-joe@dama.to>
In-Reply-To: <20260827230233.94878-1-joe@dama.to>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 16:57:27 +0200
X-Gm-Features: AcwNN1VizoTZVZB2sDoB94siA40iAhF_z9QOM3aJZ-MfaTs6002ngL1t8IbRvxk
Message-ID: <CANn89iJTkVw17sM=8Y80yh40vEHDe=tDWicGVsoLNdKBv9GDMQ@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: Prevent queue stop with deferred completions
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, Michael Chan <michael.chan@broadcom.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	horms@kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 1:09=E2=80=AFAM Joe Damato <joe@dama.to> wrote:
>
> When the driver receives a burst of packets, it can mark a BD with the
> NO_CMPL bit to defer completions. The expectation is that the last
> packet in the ring will have this bit unset and the completion generated
> by that packet will cleanup that packet and the ones preceding it. This
> helps to reduce the number of completions fired.
>
> The suppressed completions are controlled by the driver and the number
> of packets with suppressed completions scales with the size of the ring.
> SW USO packets, on the other hand, have an upper bound on the maximum
> number of BDs which can be consumed which does not scale with the ring
> size.
>
> So, for small rings it is possible that: a burst of packets is handed to
> the driver, the driver defers completions for all of the packets because
> the number of free descriptors stays above the threshold in the driver.
> Then, a USO packet arrives, but the number of BDs available is not
> enough and the USO code exits early with NETDEV_TX_BUSY.
>
> In this case, you end up in a state where the ring is full of packets
> with their completions suppressed, which can cause the queue to stop and
> never be restarted.
>
> Assuming default CONFIG_MAX_SKB_FRAGS, this is only possible for small
> rings (<=3D 457 descriptors, below the driver default value) when
> a burst of packets fills the ring, followed by a large USO packet that
> can't fit. For larger rings, the delta between the completion
> suppression threshold and the BDs required for SW USO is large enough
> that completions will fire and this case is unreachable.
>
> This issue was pointed out by Sashiko and while it seems fairly unlikely
> given that the queue size must be small to trigger this, it is indeed
> possible.
>
> Fix this by tracking the last BD which deferred completions. If SW USO
> exits early and there is a doorbell pending, enable completions for the
> last packet in the ring with disabled completions. This ensures that a
> completion will be generated and avoids stopping the queue with no way
> to start it again.
>
> Fixes: cc5d90667db8 ("net: bnxt: Implement software USO")
> Cc: <stable@vger.kernel.org> # v7.1+: 4e15e89faac9: net: bnxt: ring the d=
oorbell when SW USO exits early
> Signed-off-by: Joe Damato <joe@dama.to>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
