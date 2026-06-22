Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1AA3911CE
	for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 08:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117538; cv=pass; b=o9Et3Aqk7CvGlfjPx0tIyqhZ83xCFDAgIvB0Jdh0YGCBNVSoNhNwqeOaE9NiDJKBgPAegFQQnXiwGWGPAfv3fmVzpuBScNaDyf5E22FRvoUqW7Lcdb7eyuVPnABiaXWB7BIFXJG5SAyvVsNcb50oY1H7gPDhx4AwkJ003qj0Rto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117538; c=relaxed/simple;
	bh=HmEH2nszAumXCjlaWRxT0WmD37sfxnZ3srp9sfkifrw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiGLMouytCrxFGvdUv10Ia5CKH5mcdqsrnCSgqkvnmef5XDTwSYV/JsGSTwPdgpO0oJm5YrFOFreqO20K9DloZuKYg1xqs/pGZq1uAHzEV9XIfreyslaZYAGROmsb9noTes8vJg+mpQyl+FFZKqkjceY45EvOL5CyW21LLAF0EY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KyC0oplx; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KyC0oplx"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8dd3fe9cf10so37859186d6.0
        for <netdev@vger.kernel.org>; Mon, 22 Jun 2026 01:38:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782117535; cv=none;
        d=google.com; s=arc-20240605;
        b=MSPsdW3sp8IDx9NdVh5nx+MD4dkoORgdmxS04nnKwsaBaZSO9Haiq+XYp5kh0zbCvN
         al7+q+x5a9aKsq6O+pV+1ichLqVaMaNh0QBta0antm3Dj4oa07nUdA/nvdHQeZ/Eg5DE
         gUkfmxVij/22R968AJysobKzjw+KuLK6EslSFbIiyJ3uKEj/GfNV1SeVkatNSBVufHzN
         OK8JDF22OxZCN/KC6LJFiJY0zngkUkg0BlaJadS0Vu83LKi2/7dZni2UafuFNb/wXIQE
         LcR7pjzaUvAtfaMfX9v4Zp6MUjy1jezyMtZ2GMEnCAPoI3qgWjFLqXC0I5g2ZwJQCyLu
         sJxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HmEH2nszAumXCjlaWRxT0WmD37sfxnZ3srp9sfkifrw=;
        fh=3l3knvj0ELDDHXnQQ+vfALQwxBmtyeEPlUWurqJXjFo=;
        b=NPw46wa/8KBiSJ4DP22bNPQLaTcPONspdHxokHZ1ZfHHeo32+LSqS1Mc52UFVWovQg
         Ezn0uIzq61WgKWRoBBCc1lbyuT67VIse2S3MZ0bbDgAR0KxW9iwwGZxeOhYgx8RMW/u3
         56/J8pzLw5g0ApfTI51TANjhD17cJdJMya8EwFtVCbyDKdAC2Rw5UJhVbz2bUHdZNiXe
         2eIV6J/0avBobRiVSRiGzbQcxN2vPSQkIceRiuqaMnLTiWN3RKaUM6EuBsxqqmTvN4JW
         xnJX4HWv5I+tT3IjR5IwaYOCae6+RPAKk/qWyVBMHTYFEW1ywxccKVUjlizw28TI5mGh
         09lw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782117535; x=1782722335; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HmEH2nszAumXCjlaWRxT0WmD37sfxnZ3srp9sfkifrw=;
        b=KyC0oplxMR3RmeIsMaeXWW97E7mASypYYAMmJ2c62aWQAaNgpPBhMv+ks9aB97xu/T
         mXzjUwGtpbH2H1/j10eD2JET4J08KiUi5/cwa9tM64l/Gi8OmFcevFFUZhhiz67XKvhe
         uPzbWH9mtNU5az+E+MMdpvp8zZyp1iFlXSALM/l7cfipDnurfiGEQBj3u+wi4C3dX55w
         fBRL1AF2sLxSBsAkRriml6f/JXWnIyx+LnfAJigsaWkzVt/DPq9aQIuYtYxryOLo+b56
         Z35pdpl8bZXIMzatiTe1jr2L4iIbGuPzuk4VoQ4jewtRdTeLsseEQtb7lI/l24iWmsGl
         FoLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782117535; x=1782722335;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HmEH2nszAumXCjlaWRxT0WmD37sfxnZ3srp9sfkifrw=;
        b=UTgzHUFrhwfPYvRnUHPUM5SNZz74l0QETcRcUMD4Y5UT3bG2IwHHPT3c/rXzKGcO2w
         MDR9eusfjPYxIiRc2EI2BusLw9Uf2sqAdvFcoIicHcrXdVOMkr6dWXQNxa3oafsQqccn
         uqnE0nftn5JXQJpyENKRG1pwXF2w3D75mk5ObtbDsV0JMPN7cZe4ENxqFExW9MeeTXZt
         7uzUh8B9V+SuGpYguHdcWjF+KFxbLBpRH/DCX3wvxPHbkgGvqxLWeuNf0Ygp6kuAqjzz
         466VXGMHEfFBvYjR6w5XmjlnxHSrqY2X0ao7eg4OO+mMKlRuhIkakG5VSCcFgV6t5n+E
         BqWg==
X-Forwarded-Encrypted: i=1; AFNElJ8gJUgS2rwj0oL83/C44kYjbmVMhQhM98UvPVjivQ06pS9nyk1CI4UTdzNCskMThwY9P8vILkc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPakFXOuTxvOcKMimoSGrYfV3nois0e7cZWrYRqW/xXBjkWBw2
	NkPRkN2rQrJXJfmRvbtrIdOEgwhN/N4mt47ops8xLtRn8ZbvjuMx7dTllWaN33b2/40dW+F4dlg
	twJO5ldPegfUhQZZOjN1KaX4CExco3D/QRbVMlX+R
X-Gm-Gg: AfdE7cmPDBTVe+xVPxONaR81fhIBlvnS40oMbyr1qhCuGUQAR9E5XhPwl4MoKYtoKvo
	18OCtl73CKuJcpoTl26pP09/AD06VmNN/O03nIW8183i9+DL42cb4C+H/eBtRscYoylVQdGv9KE
	4uvpNVQHAa+60PUNDjU0pTxxGZngm7+deZGXR7ejLKjC1u6f7CFInAWYWSONrFHiHYFWAk65M3L
	1uW8fGyTKn6bnMvkTm/J/Kw5b9ut8na0eQIgRLtYsObXcPZB5g/jluJxUQVLpobyhF+L0YJV7NX
	Ye7NaqHFOJYnEjJ/sTrJK50HM5haSv2Z/I2xlsGJ9rbRiAMmbPiR4ckkctzw/d2x8q8vJq0in7X
	DRyeQ/jg4
X-Received: by 2002:a05:622a:244:b0:517:a9ef:ce30 with SMTP id
 d75a77b69052e-519e4a74ef3mr202106541cf.17.1782117534195; Mon, 22 Jun 2026
 01:38:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260621-fix-race-condition-and-crash-v1-0-87e290d9357f@onsemi.com>
 <20260621-fix-race-condition-and-crash-v1-1-87e290d9357f@onsemi.com>
In-Reply-To: <20260621-fix-race-condition-and-crash-v1-1-87e290d9357f@onsemi.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Jun 2026 01:38:42 -0700
X-Gm-Features: AVVi8Cd-kQTIhONXZohiE0GOWgCKvtvVmnz-Gj_HaUqcTRndhREIEe1fNalfyow
Message-ID: <CANn89iLLrOZ4Ep=dBgs0sC0tWsrZHy8DnCPLw_Em+7v2UtE9tA@mail.gmail.com>
Subject: Re: [PATCH 1/2] Protect skb pointer used by two different kernel instances
To: Selvamani.Rajagopal@onsemi.com
Cc: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Piergiorgio Beruto <pier.beruto@onsemi.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lunn <andrew@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 21, 2026 at 9:33=E2=80=AFPM Selvamani Rajagopal via B4 Relay
<devnull+Selvamani.Rajagopal.onsemi.com@kernel.org> wrote:
>
> From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
>
> Threaded IRQ uses waiting_tx_skb. Transmit path also uses
> this pointer without any mutual exclusion protection. As a
> result, it might leak skb buffer, particularly threaded IRQ
> runs in the middle of tranmsmit path, near skb_linearize.
>
> Fixes: b542d13fab0f ("net: ethernet: oa_tc6: Interrupt is active low, lev=
el triggered.")
> Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
> ---

OK but please use "net: ethernet: oa_tc6:" prefix in the patch title.
