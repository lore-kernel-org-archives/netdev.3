Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F8B4BE43E
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790601873; cv=pass; b=akrVqIr+Gp+65VD6FX+j84e4QQnoDSu+Nm9wcxlykhzQrRfyvvQoNpkMIFQpVWngCMSeGWMVDxaMjCCqwe1WaPwkR3biRxasiTqMhO2uRHET0HQ4/z4LLLhxxg+zKeiB0SceGBuT62Ru2w1n4Jpjgyzce/sBMSbpH3UDE6/YL70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790601873; c=relaxed/simple;
	bh=xiRS7KM761SAu0ai2HwE3HlQM61lcg6CQtVLI1LOP9g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AcJKaksVibkzJGBuwzZhWQ0DOHI4fmko/kbQpcfLU+NXwIxrc6HdGijarczOaGP/Ma9ot8KdG3tlD6o0CUSg5KG03/oBw1cNEUYrSaTd3ada6UbhFSOjwqWG9LbOTRRIwX26S4rznHDmz+TVKgVmzMeT5wZseRmq9rBsaV2KtGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O+21x2em; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O+21x2em"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-530d0d5ae11so36974401cf.0
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:24:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790601870; cv=none;
        d=google.com; s=arc-20260327;
        b=VGrlqJsHjgaGR7JoL64oiEqBITAnHEFHIirvD3kQJQfk8L+//kLCYYEZC8bBudC/tg
         fKcohtBilOKagZrl/cvCnvkvNW/8hcrAdd2JgRs2VwywzS4TCCkgZSJdRwdofHizst8C
         Vw7/1Nt+HdOopnbUpRW7/vmp5+IDPAvEDikLJvGWsEBRCFv2YFs5YsSKOQD5Ogn8UZeP
         pYinKNOpc0CQ2nXM6u+O6KVpOZa3h9yoUEBqmkXVBIiOwzgYS5l6pQQv3dXyGHEPuvOS
         rBeKJnPMe8zXNknJ2DcacwD0FaWSHS1xGKC60rzUTx11MkbFDs37cehtQYS51+Oc9T4y
         MgEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xiRS7KM761SAu0ai2HwE3HlQM61lcg6CQtVLI1LOP9g=;
        fh=FJVCf2ZkKlxqW4ONtAJwGXKb0utDiNDJ+bjOvb/hblg=;
        b=B6u79DJ1hkHBYwSPeN1pgFRQku8jdVhkhI61DoW0lxOsGEnSMN9E1nAsdUgG4JoJ2T
         w2QWCoGwKm8ivEXUNwcnhpJlyUO7pgxxBquKUqhj3DYXMLJoLetfK4AXsNWwRthwNayA
         CIUJ94NkcxqFWIcPnrD+IaTN6JrigOPoWA2udQrKB8tRw5MLrHf6nrbr0gUjQCQQ5y4y
         Gu43b7pE6Mgxqz/OSxTJrD7rF/uNcHDiFgqD5EE8S05MMbi/+OekitMq5q7dFcmfHWWl
         pL1uli8T7WbqIKHUW6XpuD4qg7cMeBXQwh0Szkom5uhSSr8vLOr5g62N49iZGqAGhyLZ
         d4jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790601870; x=1791206670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xiRS7KM761SAu0ai2HwE3HlQM61lcg6CQtVLI1LOP9g=;
        b=O+21x2em4VNXBQChDlutYjO4bHTHHFQek47IbtLW33zsSJpqZueaj5up6e8V1K7Jm+
         tRZSH9S2s0HH9llOUTShlb4s9KdLUYfUEsW+50QkWV6rp9YtvxRP3Zr0TZU1OLCNdvT/
         LsqRb3X5JjI7GUtCTHmnG59SHCpysd7CFzB839Oykyc4Eber1DRW5XVXGsAKcX7xti0W
         3lMuxxX2YJEvXa+eAnWG+bwPEotTgAF5DY9pqIp4pZViE4is+IGWaoRWZdS8C2HddPaW
         Lm8MAnYR5+QuGTEwCFH+2Ncs50qKh4rjrk33eZj47ZC6s7H2pkUWeg2kkS2kwWCAwY/2
         CaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790601870; x=1791206670;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xiRS7KM761SAu0ai2HwE3HlQM61lcg6CQtVLI1LOP9g=;
        b=zrAsixBNmP9NE08gW9BitQ+VCp3gchN3ShIzUWNJupbE5oy62ZeuVP6S75PjNGxrLz
         tCh2WSFSDnxBZm2YHaWUY7T5w+zgs35BXy5GgCBnJAuZI0mVZs84tCqkgI/OQ9vJDRIh
         viS5zaHCuPvhIdzj5VYY2WfApZw/r22gmBAb981tIr+BHn9G1mSBz6pf9y8A64Hrihci
         AsPDDM3+FuPFDf5c3k9rZuxhNDhzyr1MlWckoHCIYSQm9b7OtvcDj9H5nz+r6Sj4bXBo
         k+I1YvoGUWfD/EXwkaHsUx8JbYcHolGVg//Ifo/b8Oml3AoXGxzjCPHf4HYPK3HSW1TN
         68GA==
X-Forwarded-Encrypted: i=1; AKwUvBw1gvmhgZLgQA1g75jJ9KRHegnPkBZILNpD6umD1aWCWa27/LoPCWf6TXDkou/wNnJKKqEd0W8=@vger.kernel.org
X-Gm-Message-State: AFuF++nuvQFN+NslEF9XcyN1i/XZ5u3VBxk/tF4JPR4ZLOW0Sd65Vt0D
	Fvhpve4geQikrLTHqpZZLkG990eRjd3RRmdzbPAumbfFXvfs65Zsh6Zc2NJ9xYoOpib8/3hxK0c
	TB0dVlSC7FNDLp5YnwsPhlgu81syVWCHaOXNaComT
X-Gm-Gg: AYBFou2NOy2U8J4y5WpG7TQa75gLEM2139qgg5ga62kr5yjjh1e8UlD8DijAMyEUTSm
	scoRsAAstWoM74JckTLZX2LS0e4Urb1at5aLbb6PO6AWDKrNyiR8crHeb1mBWx1G53EFp0LpySD
	Fun/cTnPYFYBJl2li17jPMdGQTuANXHro1wHNuxkQ6J3nmgDgQyTdfHZB4If2kiWZpqbZ9sbxqL
	7fPZtLOKaUaxcKDHlM67/t76ONRmClAhCd8behadw8Gt8+8p40OPKsNkZeD7W5oPfo14zEwFMfj
	A5GACE+bmMtIhFvCLS7tb068OvOrIDUpn+7RlwFx8ow7hakEzzuNbA73GlnVCbN+dBmHhlj+nED
	aAusPEepWuz78kkZA9ydreyBsMws1rQfcEEnd0NkMBD6+E9jFjyC13x1r4a4OnGKWmbER
X-Received: by 2002:ac8:7f96:0:b0:532:c947:6e49 with SMTP id
 d75a77b69052e-5330b6d44f2mr201964871cf.59.1790601869125; Mon, 28 Sep 2026
 06:24:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928121454.901306-1-nb@tipi-net.de> <CANn89iK5RTtZLPAY+rJKCeUpLkCge+PFqfN-g_M184S9fyzSsg@mail.gmail.com>
In-Reply-To: <CANn89iK5RTtZLPAY+rJKCeUpLkCge+PFqfN-g_M184S9fyzSsg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 28 Sep 2026 15:24:17 +0200
X-Gm-Features: AclHuK_m9QSkWHN5gA-_xfWJXUJhdlyqqtSxTFTjGV0NrNiSTpS8_9j-6hAOP7Q
Message-ID: <CANn89iKouU5UvXAUwX_DKJ0G6Oap9BaUoDCjY3v+rRGDF5BBkQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: bcmgenet: complete Tx NAPI after one
 reclaim pass
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: Doug Berger <opendmb@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Justin Chen <justin.chen@broadcom.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 3:14=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Sep 28, 2026 at 2:15=E2=80=AFPM Nicolai Buchwitz <nb@tipi-net.de>=
 wrote:
> >
> > After reclaiming, the Tx poll asks to be polled again. That extra poll
> > finds nothing to do and does not reduce the interrupt rate.
> >
> > Complete the NAPI and unmask the ring interrupt right after the reclaim=
.
> >
> > On a CM4 this raises 60 byte pktgen Tx from about 187k to 224k pps and
> > saves about 5% of one core at TCP line rate.
>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> As a follow-up, you can get rid of ring->lock in the TX
> fastpath altogether (it looks like a leftover from before TX reclaim
> was moved to NAPI in commit 4092e6acf5cb ("net: bcmgenet: use NAPI for
> Tx completion")).

The commit sha1 is correct, but its true title was:
("net: bcmgenet: fix throughtput regression")).

(Even if this was a NAPI adoption for TX completions)
