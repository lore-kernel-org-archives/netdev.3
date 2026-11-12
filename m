Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794449934;
	b=chrZnhPHjspzJWiPFq7wHfIUPjiP4+WEkUJiKZu+0od+K5oVlIM1XvpIUh1dUA8MwIwc
	 cd2lCYaIGqdaFEjAnY0yJanr0l2G20JCXdsJ7NvAfcVw2WiysnT+whZR9NDdJ/r/5ecGi
	 etw+LdzKuTyWM1k/cxU7URrcrnMSfY+ErmZqed80yFAsHPzB+bKmlsa4h1DMoQhdhXLYI
	 QydBrhuSl12mpFNTrCDQbOx1E1u1g2UhIJBwu15dpPKj8crDMu9ho5YIe2i8rRIhVR0N3
	 iYs+G52Z8wYs87wUkbJPUM8xWA4Eqz7RMXfk3iuiLRY/rxx76ndtr0Do7o3Qc6pYhTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794449934;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uSIrkRDA93Mj/PVtKNG7+nFpfhhPf2AG8Tz5QutxZsE=;
	b=fbVPdxZNuImZqTRa39rpknvkL7PBXN9F2L2MmgifUAfmTyUXLfu8WV8eLWxafdvr6YUF
	 egGWSJtbbqCb8G0cezgKZGr9FUXO2ic0arUYxJIwhjCgY7g9rKqyuDD3n6tI7Atje7an2
	 56vxCMnbScsxtH2h6BjuQjrR2As9l1UR0IVmOGMKXjNDJ1Q/IocJAw/rE+MP22ABp6CTz
	 Nb5utAeitN/h2PI8YNHC/pf6dGkJ3K3VMnLM3pwXbsnbaazE/dPM8Wf0Hk/1/gQIXGwf0
	 ktkmjEOJ5E8nkqFZ9oGBzBsL6IioprjLX2ziso+8G8UFhXDRaWhtrS0WrR9VmjbBOzQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwU0Zm9y;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.42
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812FB606A339
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 02:18:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 812FB606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwU0Zm9y
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-91ec2d42231so39095886d6.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 18:18:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794449933; cv=none;
        d=google.com; s=arc-20260327;
        b=Q5nLGRnPNlRqVl9BVybRu3g/7v4Lw6sP8+kQVxN6qqu8OeGmM8CSDmxGYf8TDooxpm
         G6gP2rsBnUy6VjkKgnsndyr5ehZ3FK/B0R5BstLnG8co5W6FL9OkxJbl35GxtQTeB5XV
         a6T2KjvghZqD2/fPlCi5eomM8u7gggJ+5RpByPGKPkKoYD00qVUeAWXxNQHY36CJb9D8
         7ZE+1BbBlLA+vH+kjbA+NdEm6l0BVzjiwJemLe2cM1LTKkjLQvdr1Jm1I7E1XIOE74RW
         CYLtv/oRGOLMaE4WpXDVQcxYdu01pr6wwtw5peqt+TS7veD2xwTQuU0iSjXeDCzs6lcB
         PwEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uSIrkRDA93Mj/PVtKNG7+nFpfhhPf2AG8Tz5QutxZsE=;
        fh=YGV0/+JiWX02qbvP/rY9+S19kYXOPBN4nqJ0tgn+TFI=;
        b=M4CjCcj0DFWSQ8+7cflS9Jus3j9CIPBX6oWoLz7foLJgTyHOkZQLp503fncqqaBGPM
         yxwjrnIYcDZtwu00/eCoh/UerhLZRGNfhWbdHlAooKzweqfBoSqXqBL4KLTsfrIyFsGw
         MhDLOydlndh4mq6QnD1AXsF/HywpkyWFHwqR32RuMI/qHOuYziSgmAtcrFnHfxDckPlg
         FIX+kaP7COz8N0DoeGVUK2so2y7/5dZ2Xt8b/8Y59CjjnWKV7zAdmQuBH9Xx/R1jpUuc
         IHQ8TeN0sKKpWJITT09o43FOblJPRg8aesr1D1S1009CQsOt/ixXmJJ/BvL9qkTaDGgH
         VgGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794449933; x=1795054733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uSIrkRDA93Mj/PVtKNG7+nFpfhhPf2AG8Tz5QutxZsE=;
        b=DwU0Zm9yr9iyS23RGRtzUkYlxu4rjNtwEz5QIlNve8prjW1xbKwJ68IVgCZ4iDSHQV
         1UFlaRNHOnlTrQn2bbMJHxQdyNf0sN8YqaE3J7VA0Q0V8FiEyLtjMYDQXwnELgXhiv02
         lPrKe0xQHmdcgRQlNHiL51CS8fhjicmu/Hy/2IF+dr0Eywgi8JgfpbOU+nHntEftNgb0
         bdn7vZOvvAa5zQgesMHmMJjxCnVIDZvdC5rgLzLO/ehvJs2OefdRMyRu5/2cL40egyy7
         FBZNwnN8d7AevMrqODB3/n5vw0l3YpmCeMXPfkZJcXa6kJBohHdUYZi8zTbes9Kaa9Uw
         QrtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794449933; x=1795054733;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uSIrkRDA93Mj/PVtKNG7+nFpfhhPf2AG8Tz5QutxZsE=;
        b=pgfsT3OkmditVawpek75DRITFfij1jgH/su13tOVv0mid+jjnzJqsZ1AvPZw2NDcu/
         ZsZvNpTr6boMKgp1tG06nSWFiqOa5bmdpsf5+sDfE+m79hFqrYV69bOq0PnxdxI63C43
         FqJ4Iro4iJKok2IyX39XJ5cP3hx82Ckp5P1MthDRu2hxr0cv5jcjqjhw/qW/X+am0h98
         AnoK9B1WfHQ1gKwIbmCNE1QLSR3WPJ7rVE7eogm3bG5lbQLkMcfh0lMhjXUREF0UZJMh
         lNxOpl4SZqpkABrYkdcreYcozQmiNwrIzlr2lKDnsj4elFenA+qNnq61+nkKEj/6LWMq
         /whg==
X-Forwarded-Encrypted: i=1; AL+hErHP+VKvZfUrlnek4ZPZKs4SfNiTvFVUp1JbLXcbZcwcTGK7tjAjQ6AfHpo9m1534qc8ZMZiit8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ScnNJStNH40jGTdbPvCGhT+QTcc8tC8GEAEW1RlOu9wNbawW4
	DFdAZvO/nSAVMN4BQ6IsUpJbh6vmb42jnxqEjouWZjhnQlxwJ0f0HLpLtZt6Mv0lQdGKkGoegd0
	GcUGawETy7PjDBiJGgR2SVqRGiVS9hYs=
X-Gm-Gg: AYBFou2ssayKnKXbOGZ14DaawjAlQ+4U02k5Yju02hQdEnHCQw5P6F5niIH9MJmO3/1
	h3q5bK84MZrpjaEPBI4Ry81vA2Aslq2AgPK3Y+2q3IenYx13Z8UIR/vLvU6WvB5cyOTIqcU4mlf
	nTz/RQIkue0hTQWgjyXiB1Jzz2E45uI4MluMoRDcy2PLIDY1ZTMf9cuHQghuMB0y0EcOxwqQ8aq
	ZQjdh9ALvj5GQWNk3L01oYnZ4ABZEscqb2B1kdEwA1pnch+nEyrUSr3BtiDerFt5KeME254mbBZ
	A1J/1G/NDXYvYGROOuDiImGCxoVwAW7z66sAzEqs7oracYjmDDjnO3fpTLlnM501E9+eHrX2Gu9
	Y6H49om/EOBqrh8qYf2wDemSKQgCwq48pARf0
X-Received: by 2002:a05:6214:6112:b0:91f:12f9:fc6e with SMTP id
 6a1803df08f44-91f12f9fe1fmr26500366d6.31.1794449933323; Wed, 11 Nov 2026
 18:18:53 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109134506.2794160-1-zxyan0222@gmail.com> <179423231463.488859.16977464890948797360@kernel.org>
 <20261111152012.3506cf35@kernel.org>
In-Reply-To: <20261111152012.3506cf35@kernel.org>
From: zhu xin <zxyan0222@gmail.com>
Date: Thu, 12 Nov 2026 10:18:41 +0800
X-Gm-Features: AclHuK8QI62ccttn1Xw-oY6fIZrapeK5u9UcITSCWeJbJUttr5lLmZTnCyZA2Bs
Message-ID: <CAP7veT+buHRMu6f3o5RaKFdv3fABkWKgkO6KFn5js4PEeB8b0w@mail.gmail.com>
Subject: Re: [PATCH net-next v10 0/3] net: stmmac: dwxgmac2: timestamp
 interrupt support + Agilex5 fix
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev-bot+sinfo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, maxime.chevallier@bootlin.com, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, 
	richardcochran@gmail.com, muhammad.nazim.amirul.nazle.asmade@altera.com, 
	rohan.g.thomas@altera.com, rmk+kernel@armlinux.org.uk, 
	o.rempel@pengutronix.de, wojciech.drewek@intel.com, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

On Thu, Nov 12, 2026 at 7:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 09 Nov 2026 13:51:54 +0000 netdev-bot+sinfo@kernel.org wrote:
> >  - What hardware the change was tested on. For driver fixes please
> >    mention the device (and if relevant firmware version) used for
> >    testing, or say that the change was not tested on real hardware.
> >
> > Please do not repost the series just to address the above. Instead,
> > reply to this email with the missing information, so that reviewers
> > can take it into account. If the series needs another revision for
> > other reasons, please include the information in the commit messages
> > then.
>
> You are at v10 and still getting these automated emails.
> What's going on?

As for what is going on: I answered the bot's full questionnaire once,
in a direct reply at v7 [1], and since v10 the same facts are
described in the cover letter.  The bot, maybe, evaluates the
individual commit messages, where I never put the information,
assuming the reply and the cover letter would count.  They do not,
so the emails kept coming.  I will fold the tested-on and
found-by-inspection statements into the commit messages with the
next revision, which should settle it.
