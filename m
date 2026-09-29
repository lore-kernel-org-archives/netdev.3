Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3320A3CF688
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790660274; cv=pass; b=uxDR62wWn6WktScfW5dd4CCN6M8iM4UXxogSp7FTSYjD8RGO93Qf7FxWrhHd3bJxISvbR84isY1x+guYSQzEeTk/ove95NFfQY9Gx1lbZZ0ZN/hVhVBj1JnIA6P2tMqShLkqU2/VG1ncb8oGu+9h8/4sOpfheBbFXMqSZIVX7xc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790660274; c=relaxed/simple;
	bh=mGEEXHKxugm1ji6dPF/Vka2irdvzEg3Ov0k4PxuefyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=eauAKJGxNmV1FJto11qKw4jfkcW6XK0WKGXjxiH1DfpZwlN+RwFIxnrqT2eqVzBGf5wjz8BwNEFslzZ9jxDkKJZhMr2GuL+6EBaGbLuh9gSflhV6OFSFaOxGQE+hg+1dl1ULr2KaP5CbHffJWxGz+PQHZ4XEnT0ZMN3jFG19dxY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHMl6NBA; arc=pass smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHMl6NBA"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3a76ac0bdafso613121fa.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 22:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790660271; cv=none;
        d=google.com; s=arc-20260327;
        b=fIxhoCdqh9A1KNDvZNkPmvx9JDDzJMseLU/8POowvIpGRZoTmQKGoZMik4We2VKK8P
         jiWYFQ3MvILrW+qV0xkzE/g5TSDy/1X8n5K5adzVa/r93joAnN6cmxczrIN3vdBN6djR
         4F3Uw6bpjXIlqgbOM3O7oCmQrAce5CmISfc5lFoqkBKIQjWRsYIbRNZ73pns9jgfTOxt
         p8qeAPCH/lnodCuoetUnA75AJONZHW48W+iFXKTf2TN8SXcnoUrzYUOuFbeatU/glcWp
         tLzVmSVFJr83I5OPVVO1DJ/I/dbSPQSp/l+qYh1DTqz8/NWOwEr0KRXv6QslKvdmHBnx
         jMsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ywMDNY3EI7iDZTym+kV52AlLxDjfRMFnaIbif0jeJZU=;
        fh=4INox0qVL7jvLvevYqpx9KmHV/ykbzvpPMjngNvt0nQ=;
        b=WHNkQ6RotkEewEuR5TLw/0sNA7shG9eG/zXEbMrzblv4Mvq4q+ZB7bgmc7cy/9UeZ2
         AgBRYZW9BlCC9VOn1IDNl2vLtpw0MNpDqVhUNRLrc1FAFqKXdHakwH2Otwdu/w1Kevi2
         DuiHXd9DDpLBT3Zv1mEeYYIIGxQqrUQ9mJ6iclD9S0zkt+JYWUbENha4CjVy7AFdWSYW
         nAzFFlU4/EflHTOrtc1RHpcO6ennOgPeNFrwHo+ybhJhr4W2NyI20wWkHIrtvH42tN7B
         Je6YajudMxWVwfjpn/ATSdKNL2JwibaDOOsKtkY/uCL/4+HDXVZx5QwbstPgFZoWVT3j
         zkxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790660271; x=1791265071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ywMDNY3EI7iDZTym+kV52AlLxDjfRMFnaIbif0jeJZU=;
        b=NHMl6NBAU721ciWyDdItxZBecriRV4fL0N1xWEQR7mY38+Gjeactn4MABx0d/2SZna
         92yndCf4VZ8L0hv/1dk9qOlbWDM4hHXJp0vaMMeEA33grbpeUKAqNWvPGFZdiF80CmbM
         If4EsEFlHjOTOJO2aswpG8qdya5K6sd2vKZyTrXgb6zUfEdlnSdXlUFrDWbjkNliB+IJ
         bcpI+BZl+9ofEi8+wxOKN+UP3JlESB5Uno9hx9btGwm7YV2Ux1WJGAAqiglJnIpyoETT
         3gMlbzIoLueXusJqyx3mBH4yVPFEV3ZUyJc7Pzo3lzeTND/Rm2K/gKJ4uXs3yVTgk1cN
         SFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790660271; x=1791265071;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ywMDNY3EI7iDZTym+kV52AlLxDjfRMFnaIbif0jeJZU=;
        b=lo3ZF2uhr1TqvIYcU0GD3JNNTCr9gTmRPJ9hyIfYriZISutE2hw7lsW8WIuCEeqjRX
         sEBbq/9LlIFuzsiV2XeGO0vG9RrRyL7XRr6wsiuZ92ftCNyWZRFcJEIqWKBEXLRT7iCd
         9c+JX4uNcMXM/fBcDxJUzWbYely/YnnyfxNdzOQfYArAS7IFnaH3PSJLR9p6Zp1qIlKi
         nmuEFdH7qcSdLNZMBMlkYNQ9NCrLgcjowAySkK5/mzKUDvleMsJTq78WEY1Sw3Y149So
         swJ+K44WDlnEFQYqjoUOLY8DTtPCzNWAg7o4qA0rRCu5/Vg3S97nfP7zVPZw/rT/Kb2k
         jA+g==
X-Forwarded-Encrypted: i=1; AKwUvBxigawNxzx9kaJJDI6K7wQ8vQNDZI/Jcymu+LXFbGv2E3A/L3EhulSN8xuzb/M3p1e6VNz6H1U=@vger.kernel.org
X-Gm-Message-State: AFq9FYL6HEG5THJW+6ZznC8JrADnJnBkYXSN+2O1lkUKmwxU11PW+DfE
	FKWUgWb+izNRFI4kLcEUA/g73SMF+sCO2h/eEVS/jLqjrdBw4MsLOOU+OYQJNBBXpjUmzVUTQH5
	ufFI0F4vBWhXmO/M9WaiGma0Y7WtVGxs=
X-Gm-Gg: AYBFou22FL+RwNCyqWMlD42qsLJI9qKG4gBcLLKn3NvXnfQcZspIiUQ5fPpEj3HgFsd
	QoySXz/ofB9tHv/UmA27R4fux2NV/fU4Gy3i8JFa2Jt52pq/R/ED8kaJ1sYgALKP7mAZErNLgee
	F5/CuHnZKGsScJdMyg09rrhJb/knkXa2EXmBszXpDejqzjmbGnE84suHj1VbjJSHBmF6BIgGAPN
	nSruBmuLDvHWd2/Go11P/eVaCrsYBQmw6aJUidU0Kln2SEowKxcCIih9EUbx86bwGldquKmquJR
	wGxRfvcQcDIz0d4HPKu0yhjvrSU/vrzmuvfOtxqdYUhHG174O8EeMw==
X-Received: by 2002:a2e:a803:0:b0:3a6:62bb:906e with SMTP id
 38308e7fff4ca-3a76479b880mr2991121fa.20.1790660270947; Mon, 28 Sep 2026
 22:37:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927081034.350422-1-maimon.sagi@gmail.com> <arsCWFmUhSYkhcCv@devvm20253.cco0.facebook.com>
In-Reply-To: <arsCWFmUhSYkhcCv@devvm20253.cco0.facebook.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Tue, 29 Sep 2026 08:37:24 +0300
X-Gm-Features: AclHuK8JAeWlDi0d7__PRO1w7MUiU220HLhnmM4wnT1m-kDeU30Mnzj_nbHR38A
Message-ID: <CAMuE1bH_=zqxf0-cfJozeaytGmK=q_WK0iwVxP_yH+AkJxHO=g@mail.gmail.com>
Subject: Re: [PATCH net] net: axienet: free outstanding TX buffers in axienet_dma_bd_release()
To: Joe Damato <joe@dama.to>, Sagi Maimon <maimon.sagi@gmail.com>, netdev@vger.kernel.org, 
	radhey.shyam.pandey@amd.com, michal.simek@amd.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 3:12=E2=80=AFAM Joe Damato <joe@dama.to> wrote:
>
> On Sun, Sep 27, 2026 at 11:10:34AM +0300, Sagi Maimon wrote:
>
> [...]
>
> > Walk the TX ring the way axienet_dma_err_handler() already does: unmap
> > every descriptor whose cntrl is still set - axienet_free_tx_chain()
> > clears it on reclaim - and free any skb still attached.
>
> The code added in this patch and in axienet_dma_err_handler are almost
> identical (as your commit message suggests). I am wondering if it's possi=
ble
> to factor this code out into a helper and instead call it from both place=
s
> instead of repeating the same code?

Yes, the unmap-and-free part is the same; the error handler also clears
each descriptor for reuse, and frees with dev_kfree_skb_irq() where this
uses dev_kfree_skb(), so a shared helper would use dev_kfree_skb_any().
Since this goes to net with a Fixes: tag I kept it to the minimal
change.  I will send the helper to net-next once this fix has reached
it, if that works for you.
Thanks,
Sagi
