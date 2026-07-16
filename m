Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE1341A564
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 11:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200954; cv=pass; b=IfgSX4SOLTrMfW4G55by0dmGyJypYXrE5/ksrQEGzJfmVmEV6N2ZdpplWETXPx42g4OCC5clJN4BBprgPVfFyZdFUlN+ebkHgZD9+9ESwaTQXuD5ILxpd7Imi+EJENH/qu7q8SXVH+KADjRXypgRsUgZkvOxirLA3bZfY3+6iFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200954; c=relaxed/simple;
	bh=HPb5WPC4lCTgEt30xhiUbaSUaPQItUNr9aD0MaQHPaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OeoXulQa67uu844hnFKIBej0QddK+Zvm0pQAryyw96cOdTLuHHDh5Zp9wsISe3UID+zPgnY6r/nMQpf7CsLPY42dY9myWIRoeccO26Vy7TlxkNDVPd30JnKcDpEeMAtu4bsrRTpPqBqanIRQKUDmy3mQg0Qmra9tmTfNTyQbZZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hJspsvdG; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hJspsvdG"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-69c7c8accffso8757922a12.2
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 04:22:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784200950; cv=none;
        d=google.com; s=arc-20260327;
        b=ChauLSOF8S8zO5yJd6+SGe+uhnhfNqX68sZjoEzOWQtzcuW1Ptv4JmHi8yzZhS1/DW
         ON7uVth5EfwehySLAyd6mRORXkBd/V9dtv/AVsJHxBtBBE3iogMisUdp1aZswjLy9Grd
         D4rczV82ylCUPgF/ILuJbfVUkLkozb4+q5ljjyr17Ctx9JsCJPWpDVm3jkbAAWMBJXY9
         jgjFSQHso5UF81KAecqVAO2ONJ6uh6ql7oQVafsFmoxfk+11Zt+IdVZWqhOsoqTAZ0Fv
         prhwhHyM/Yv4nynhsd21qpY6B//UFCtZwKU9XGsl19J18qO8yYU4ELwwPV1EAHisK5O6
         8fwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F7PLUu8CkOddbo13f+x1689IvQHMTxkc+L3wTNv9ExY=;
        fh=3w/0BPL8Vsakb06+ZzBGzhmrsTR5QXxfr5haMleCX0Y=;
        b=U7o/v603QEKP1RpRn/7I3/NP1MtJSZC8Lpjf9SlPNmfbSpBlZwLu2IwTyDmQa5eFqe
         1gcGNwXbdbSfyrSW0WUPAltuCx6r2R0JK0Fl/RrRPIZpphV4G/1/lC95jDKhjvAPVrtU
         fNeDTby3396mi0seg3fnGxyW1Qbo1de7x1bcgZ2tlv7XI21xoVKPocEb4W70zbAqsv/G
         5/Ld6RIRn9PIJ0nRrEdGVOMa4MEK49XgMsN14L8bVmF6ujNe2ysakhkDSmB9AaclmmBO
         BYkhb/exDVOrZeNc4myLzfxAlLnvKUYC+JE1iM0b9t78Ehy8CePKhW8fCobHTJok92Y0
         0Kiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784200950; x=1784805750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F7PLUu8CkOddbo13f+x1689IvQHMTxkc+L3wTNv9ExY=;
        b=hJspsvdGqeWz3kqfIsMzUQ1OPAddpQ7SL8CkhC2J83taRK1A3hZqmFmxZdDe7EEQqE
         ns/tfaN3gRa7IIyHbUxHBE0wYEcpuv5t0vwtzCIC5lDUkDVu0XQuDyvUhnzLrdyf3XS3
         dekcSuQuBjJSNBDja21Rrsb+hsmPvqmBxeTIv0lp8wU70g42zyW3jo2h9bYPXGc+HVnw
         cFL4gh34aEIH4rOMpN0JvHpnVilEJABcYO9JmXv2dNzAkW8O4ZNIhB5Y1Fo4GWKv6uVd
         un4H3DuYitn+vgS5W85y0atrNgaFo9pDC54YbloPTGgKgOvWu70LxEzdMMA9z+tDjbtr
         W8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784200950; x=1784805750;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7PLUu8CkOddbo13f+x1689IvQHMTxkc+L3wTNv9ExY=;
        b=gbxM8feuyIlvhQEMGLxrr3q83QGTM34mzvVimqTiRpvpWwtNoVbBUjJBfsM2tXI03p
         5IbPOtVi2ia6AG7zyzUaeY80CsnLd/5QZWICE++J8nNGsAhi5C3oVV8rVnb2n8XT2mqL
         +npaCjP4vmahIvokkhkGXuaZwQWFWEa8Gg2jWxcmn0Jh0EV6MqanftjGfTo0fZtA8pdt
         5YOZJ8OZlhVrLkRbJUq/AwEv1vEOkC3vsCDwBQ+7L2AEpjvmpcJsFiDVtGC2RDXUo4PZ
         jgQ6gnhb9Uu0xvIrS/5qWYfabtEQ9GsL8PT+VqU+4dI/S+IgY6yoyajIOkBl6HeR+KgR
         9f3w==
X-Forwarded-Encrypted: i=1; AHgh+RqUMdGJQn0JRoMWNDanMvp3CuD4QY95fdZnuP+ZgYXB1nbUievSZIewR7Ye1kDkr5acJw3LG9o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/2okNzuU7TOz2nA7QcCeEGmvzu1CYP/mnV4tyOpRJvEn2CDwd
	k/hqQIXTw/E5L7waQ4E7wMEsQmB212zpyyigFOb8noJaHz/T5fKr+j4qVifiNAfRJqAzzC3F3iX
	cZG/3BzScT1BAjN0iMPxJQo+UaDZ0lxY=
X-Gm-Gg: AfdE7clfRtjNRqWhwNkonENiUeE4X1fC9rF0I95UlgShMrhQnBRonM0+SfrhXaMckHT
	IhFo0U+7WsaKT22Q6Q9n2VH+ii8EWL1Uv+sVQdRmsS4vKIJR3w2Ma7zb45cR7MQBDog36rDD60N
	g9pQCNyOL5lb888I0sXYKb0CZiAMXW4G5G3HpCmqTUT3n40cgIvNJW4P/XGQUGApaF4JtMz+lZ/
	kuKurObKTxJULiHugEVcBB7jNgfJFvwmK2A1mIjkcjf9CdA2VCndx5rkXaW70lZjbLazMzgg0wt
	bSPrAPhdU1Pm9jg1poVM
X-Received: by 2002:a05:6402:42c9:b0:69a:6f1:d2e9 with SMTP id
 4fb4d7f45d1cf-69e199dfa7dmr3605844a12.30.1784200950281; Thu, 16 Jul 2026
 04:22:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714020340.25014-1-akiyano@amazon.com> <20260714020340.25014-2-akiyano@amazon.com>
In-Reply-To: <20260714020340.25014-2-akiyano@amazon.com>
From: saeed bishara <saeed.bishara.os@gmail.com>
Date: Thu, 16 Jul 2026 14:22:19 +0300
X-Gm-Features: AUfX_mwI45KknVT_65FZwLBjVHUIxU-71Sc82a4VjAhyLSVgrPTPeRc4elHkh1I
Message-ID: <CAHfVqdWBsBMqerM7mq3U0fMKhCSMUd3nbNFi1vgFehRivG5B0w@mail.gmail.com>
Subject: Re: [PATCH v4 net-next 1/7] ptp: Add ioctls for PHC timestamps with
 quality attributes
To: Arthur Kiyanovski <akiyano@amazon.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Richard Cochran <richardcochran@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Wen Gu <guwen@linux.alibaba.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Woodhouse <dwmw@amazon.com>, 
	Yonatan Sarna <ysarna@amazon.com>, Zorik Machulsky <zorik@amazon.com>, 
	Alexander Matushevsky <matua@amazon.com>, Saeed Bshara <saeedb@amazon.com>, Matt Wilson <msw@amazon.com>, 
	Anthony Liguori <aliguori@amazon.com>, Nafea Bshara <nafea@amazon.com>, 
	Evgeny Schmeilin <evgenys@amazon.com>, Netanel Belgazal <netanel@amazon.com>, Ali Saidi <alisaidi@amazon.com>, 
	Benjamin Herrenschmidt <benh@amazon.com>, Noam Dagan <ndagan@amazon.com>, David Arinzon <darinzon@amazon.com>, 
	Evgeny Ostrovsky <evostrov@amazon.com>, Ofir Tabachnik <ofirt@amazon.com>, 
	Amit Bernstein <amitbern@amazon.com>, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, shuah@kernel.org, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Simon Horman <horms@kernel.org>, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 14, 2026 at 5:06=E2=80=AFAM Arthur Kiyanovski <akiyano@amazon.c=
om> wrote:

> +       n_samples =3D data->request.num_samples;
> +       sts.clockid =3D data->request.clock_id;
> +       kfree(data);
> +       data =3D kzalloc(struct_size(data, timestamps, n_samples), GFP_KE=
RNEL);
> +       if (!data)
> +               return -ENOMEM;
any idea why you free then allocate back?

> --- a/include/linux/ptp_clock_kernel.h
> +++ b/include/linux/ptp_clock_kernel.h
> @@ -123,11 +123,34 @@ struct ptp_system_timestamp {
>   *               reading the lowest bits of the PHC timestamp and the se=
cond
>   *               reading immediately follows that.
>   *
> + * @gettimexattrs64:  Reads the current time from the hardware clock and
> + *                    optionally also the system clock with additional c=
lock
> + *                    attributes.
> + *                    parameter ts: Holds the PHC timestamp.
> + *                    parameter sts: If not NULL, it holds a pair of
> + *                    timestamps from the system clock. The first readin=
g is
> + *                    made right before reading the lowest bits of the P=
HC
> + *                    timestamp and the second reading immediately follo=
ws that.
The descriptions for ts and sts here are identical to gettimex64.
Instead of duplicating this text, could we just refer back to the
gettimex64 documentation?
