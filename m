Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B528834AB19
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785868300; cv=pass; b=jqlDqz51ltxhxNp/rIPvzud/HqeTfkLerwspriIDGOECxHHj3MyOYobomkWP2jjzmsk96UaEPWhUkohHCfyeEUJQo/Kj9OE4Z4APxi7QlzS12CleaoIxfIJ3uSHHS68nADOXt0uqjjUN135VyhqEZHr0xCd8G5O30+cPo2gvQKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785868300; c=relaxed/simple;
	bh=J/En1C5hIlRgS5P+Kb5JhJHyJnF1jC529V+a2OjcoMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VuHpNyqhAlN0y4ypxivQWt8lqjHtsQP92vJqqKh0mHzzFAKhWHY5ZSdwZup7uCPMIXqForwc3We9R7f8ihqEzQQtRozq63pKemps4GnmkwmQS1aY/+hxdiqXsSFEN5yKloz7QG8K438h3XSI3PWy7PvBQ9J1A+6uOSgA9Q1he/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8Hd0Bcu; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8Hd0Bcu"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so130322b3a.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 11:31:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785868299; cv=none;
        d=google.com; s=arc-20260327;
        b=RPkReoaVuEsqlB1uoJShRi+gHpDHa6oDMXyXF4Rmnm/AF35HKJ3+kslfx9PqYAA+sa
         84+GYBqIW7MtpJBe89+tFmuuNRE713A5CfX/EqHD3B+Fmko7BTkGFeWSYcRu0ckI74Ne
         Y8CwJ87GnUfGtB4SWjdC/auftqi3kqCtN/lLUheM8JS8sziH+lZ1KcQnkKZ/5lekZkI1
         A8f41d+kvg3Ni0vJt2NwkZfGuTY5fjIYLmoBK7YD9pZmjhc3AmNrY/N4cPHVuxQD2d59
         tLp+H9BEKZEJwGRcz5y7VOoUHRA85AaTK6Eq0pyxaPQQWl3tKeDeU5SnZZnZLNgxW+sk
         yM3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J/En1C5hIlRgS5P+Kb5JhJHyJnF1jC529V+a2OjcoMA=;
        fh=7bVRqDBO/IILfp2K1eFjEEKcbMlKAGRYK6XOIviqOac=;
        b=ZaZFSMvJb2Ho88cUDYWc+L5dwUCCFVEzLvMX1P1rN5fyeQw4M0ahCyYCdotWZU0B8R
         zsa49+13Zy+33Tz8cTmE1AcYx7lokonFsHHK9ZHeDkb7DwSiUL9mpk+6Khs1BpAAcJGd
         fdTqCisZXtg1MN/L8VSDUju10im1v7M1hY/mrmPy4e9zjkb2ICzJ30MdoLQ90JBs/GmK
         CSj5Kde9xxTAY5AHYaJ4ASRgFGy+d4TscjhyTudDJk+t15ZatHgdVgxXsRJtmxbPstKD
         1vw6xAGhF0dy3TY8ObZLb4Km9fK2M6TKk/nBaGn214o5V5qb19qxs93wj694PmDt9VHr
         St8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785868299; x=1786473099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=J/En1C5hIlRgS5P+Kb5JhJHyJnF1jC529V+a2OjcoMA=;
        b=W8Hd0BcusroryyIo1zuvxaxGE5/7vpCH7LNP3/omnil+3os5MOQcgb9Jyh+3hJG6LA
         R6C6UGqp4b9eaXpbHP7nTYQIERehm0yM0fnOl+pVHThcYaWGQxapdQdJ8Nw5O6V81ahn
         eRIu7IdqZMiCKkTA12fIoOHULCpIeal9ONuHwGT3ukHWb7O5hjvIvtUQSb+69zVLGESU
         fCwoaZ0zVt4ygH2RzWi1Fa9gRbhI5gkdeIyViNir5FHzvruS5ZC6P3x6mJerf3x4/elP
         LMzbZ3Gc1R/lTzcKMGEUZeza0nNBH2GnXxRVrvT0bLmQ9Eap/tjEYm/xymSCeC/B2lRw
         nwdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785868299; x=1786473099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J/En1C5hIlRgS5P+Kb5JhJHyJnF1jC529V+a2OjcoMA=;
        b=pEcZYL2yvVMYNVC5uG+oXMsyWPjLculzoGp8ayHAgMqw1pkrrXEAbliPtATMeryVBK
         IBVetEAV7lTV/YRfhQgHOsFWgs9AWGms7bw94IYTTzzabHPLDFRSo4Z8Ej0Tvf5FY/hQ
         qJSJE1zk7C9CrJBCp5y4t4rpPqienWPzSzslGSYST4mqOZ+Ed/yWpl7M0i/NUjEgFqTz
         3HXxVpvmQ4+oivkTYuU3K8BaEKPXjv3I5pXtFf3KkHCX2cMVIZjTVZrFkeTVClu9N/GZ
         QzUfnxjLEYvLwQEPhR9s53dGxX8qdjlhb9tjDiTG2abZvrSKsb7RUU9XILEopQhR6Kj2
         UX+A==
X-Forwarded-Encrypted: i=1; AHgh+RryA3emnQdz9mn55Ep9PL6BugNZJoNZupTe8SOGqebS7VSfijFMBvkUXc/ts2CWaoUEkOs0PGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxROGojuhJfeQPgcaEQMK3waLJWoHRiTj8V9olLWO+xH1C3YuQz
	7VhFbo716Go8ri1gYJnkpcuvZPkxOQDs8Oh1YqBRvBjQapnbnrwV+rzNzSWIyRgxttnF7s4jUQV
	QY8hZmvxlmQgVUIEFH6rehW8c1srV4txQVZPM
X-Gm-Gg: AR+sD10PWYoBA8kCurG6++wIypY+TihrdRE0dgzAKzzopH231zbsy7M2PCrf7HziH+V
	QV34P6ngUkn5TEPFqulFjHSEwgFx7lr9XIwYxO/fAGbNZUtF2iH0MabOCWRlQWlk2s+zViDhc+a
	p3WicA6muXJXSSsmJIHy+uOV341TXBefOTym53zPuYCZCD4r9Ssx7iOjowtSZzpoFS5EahYEbgg
	lFRoe4fqY8AmLT9GqqTXg2vZSBLRz/aBCd1oREvLt224meuTRGU/nSS8A3XMWsw/DssuKVoDA41
	xNhX4OFolsSA2zCMZX+irpgCLansqr2Wdkd9pcasRP7DFuf8FYlpcQGACs6nT+W6eAtzXkImuL9
	Y7v025asgc23MfU51RL4nQkYqLzSUzCTt2DzJQaBsu4U=
X-Received: by 2002:a05:6a00:14d3:b0:848:63c9:ee38 with SMTP id
 d2e1a72fcca58-84f2e13adafmr699337b3a.39.1785868299014; Tue, 04 Aug 2026
 11:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723071818.459034-1-l1138897701@163.com> <20260804025514.241767-1-l1138897701@163.com>
In-Reply-To: <20260804025514.241767-1-l1138897701@163.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 4 Aug 2026 14:31:26 -0400
X-Gm-Features: AUfX_myhMPbxHNBRRr3ZaLA4Ti65K3gITutgTaweuLNmSAh8E6QJx-yjU8fnmS8
Message-ID: <CADvbK_eDoT4WC21QvP_Pnp4prMv6YUODYPGN_cPuNVc3bs46-g@mail.gmail.com>
Subject: Re: [PATCH net v2] sctp: fix addip_serial increment on ASCONF_ACK
 allocation failure
To: luoqing <l1138897701@163.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-sctp@vger.kernel.org, marcelo.leitner@gmail.com, 
	netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 3, 2026 at 10:56=E2=80=AFPM luoqing <l1138897701@163.com> wrote=
:
>
> From: Qing Luo <luoqing@kylinos.cn>
>
> In sctp_process_asconf(), when sctp_make_asconf_ack() fails to allocate
> the ASCONF_ACK chunk due to memory pressure, the code jumps to the
> done label where asoc->peer.addip_serial is unconditionally incremented.
>
> This leaves the peer's ASCONF (serial N) unacknowledged while the local
> endpoint now expects serial N+1. When the peer retransmits serial N, it
> falls into the serial < addip_serial + 1 branch ,
> which attempts to look up a cached ACK for serial N. No cached ACK
> exists since the allocation failed, so the retransmission is silently
> discarded. The peer eventually times out and ABORTs the association.
>
> Move the addip_serial increment inside the if (asconf_ack) block so that
> the serial number is only advanced when the ASCONF_ACK is successfully
> created and cached. This way, on allocation failure, the serial number
> is unchanged and the peer's retransmitted ASCONF will be correctly
> re-processed.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Qing Luo <luoqing@kylinos.cn>

Acked-by: Xin Long <lucien.xin@gmail.com>
