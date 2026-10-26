Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026695;
	b=TYZLkqkfrNcW6E9YasA01TV7JotKWKVEUERqGmwfzx4d8DmTOSn7gWBbKd4C+jxWTjDp
	 Rangg2asmLL5fDmXcsiDAWsnviRO8eJ2irh36XSHfO7gU92TBYkkdYdHzkRmvZxV9skvc
	 QxCnU3lIbptvajmUpZMbC+EsKbkMl97YDinOfV4Q+Mr2ml+BSD7L5ExYJBa0BCIHx9pm6
	 BvvKNXachnNPBnIyMgA8ZEP9Z050EWMtBkaGSwGovQD4pWcWQmEKZhQ6inG+iMhO9vJ1v
	 y5bzkJTb/TiLcP1Rx/FuVNaxeQ3o4d0XZL/pbDefkM0KspUKf1bhv44coSR1400+zyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026695;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=FJS89KuNZwh7/7cErKHYPAXh9YyRaZbbAgWp3J/Ttec=;
	b=A8apIQjITcvLehN83zv7uc2VsIQBOl+W+8A/l2rQrS1nKYXfSJsdRQpjsUcKGKY2vARy
	 b75HRO1ctwdH18u1DB7IjDoQW0NAu6T21MwcJ7nCUqwipPmEybmhUSlz0z7PYBXHBk2mr
	 3s9GoLCiYdbW9qqbMF1WW1yw6/5h6c857ZIdB7cSbT2jHQ+8K6gBNOnOPNluVoDDS3mfw
	 AQAiZFfW7NVbZwgarxjCThsG6RBVqt/qMtwwm3smKpAX3hl4h10Nl+BP1TuN9UvWE+GxK
	 +m2W0gaxH+6EdJzhaGIBeb0sZbwFVb0xedth2swfhOGCP78vLnraWjTHuYuytDLjQeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=hG6q6yQg;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3508606A326
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 14:58:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3508606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=hG6q6yQg
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so29743115e9.2
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 07:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793026693; x=1793631493; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FJS89KuNZwh7/7cErKHYPAXh9YyRaZbbAgWp3J/Ttec=;
        b=hG6q6yQgnImNhH9iUb0H3TAMaZ6XUqV0ei3aaw2ghXRT929UaGAYimUg0iIa6VeFUh
         jWGG9Mq7QpZWkLoRa1nteywXfHeLQTJ12a1aoDgfV2RrIb9qpDNYmdxT0g50ad7o6O2v
         4lE3401qAWMKmJ/H0m4VF4Fj1zcJb0ymcxYv0OsnJH3/Z1zAaXev5JQYXoyYDbPwJyuG
         Rm8J/wtxoxGSMpuXBSdvW4nfI6zb2GiemVQqiv23xsuUIK/RrX8c8Kdvc78BWM9Pj0/m
         hoTQ4jXiTSbUSoF80Ob7exNxamKuuN3lHgnD4QNSoYxvS2+Asb5HlY6wqZf6vG1yWndd
         T9ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793026693; x=1793631493;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJS89KuNZwh7/7cErKHYPAXh9YyRaZbbAgWp3J/Ttec=;
        b=mNSJnoWkxzbJEJ6y6dQXsHXAk8FwCG7hGrlHtjY12pBI2priOJ7Zpwee96+avKFx83
         pzkSvG32ejwY5rhY3Ha7MtUxOuz7DfcwvyVVz0S9CiUVVfs79IfqD9EZEH6cp/v5QgJ+
         fpTyZGmGntvDdC3qZ5QzdkzBYcncx+Xz+ehjiSukKgNpH0GGFIwmGOLVM8ElDwAnlJgI
         GZJ4Neqbw8mL7yVQzWpw0dl1i0ZDLnlRzVST0OhgM2VxVD4KFFyMBMfq+y+go+87lXAu
         ZDNHyuy1sxztHV626+HH+XBxHMpvYg3OM54QILJVo49l4rwq0EAVEetdare4oZtLlwPq
         5B6Q==
X-Forwarded-Encrypted: i=1; AKwUvBzAD0LZab8LeB+7vgg9xua1ffIER99LwTj4h3R9ti53IjUL16FwqfjpALoRBPHFzfBJE0+p7qE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpE+p15H1c6vvEcyj8fOb9OvGGzm1ZC+8mMFrSPFTfmMS9KZQ1
	cajR/69RiQMzwxD5MlPXEpyK3hzGFGz6zFsWIM0zyXwEieFvuUfL8E+DyJGnokOjUzc=
X-Gm-Gg: AYBFou0Pa24HbgT/8q647+IAULfsFWxpDq6+YaHC5WgeBU15+CTL1fkY3qqH9APOHqP
	Nd4YE98TgeBP5wd2d7L8/tyUmwH/upUxm0Y0BQUUmybCQ03BheeMe0kHp63GKXk5yo022axzaYX
	pOXetIoUzmE8ihlZL+w9VWLsnmS6j0XTKl1ArECcTwOmKuNAVjI1C4cxO26VlO8vQ5qT2uhNH++
	ycUZqsE6IBiDdqnpyIneEwIhevBNm5Sk8bxTukcGOogZkUC3cJqjaDXM9aIjI/YBd8Tps+BzNEn
	qa9XC25RgmrXaCuNEl38aICmeWPEOMCt0N40ylGl2C5A4VeYejZ+Ikv4sl9uGNn3vNPh3jD37t2
	P4rPMXnbcfJ3r9+XPDPgfRKUMMoVupZ+/1uiJgwtsQrGuggkzVL/hX+k8aK3vlDMwjzgmCjyIS8
	TQz2YKrFlBN+9/svC4yHDOsrzxZMZUAY4atSNRGOifDTs4nn2vzOYudMXVTg+wIXCC32Sr8/lTt
	5gGnCjnLK3fxsSa/WbruxnyiSRrUiyxMZlHUH/IJgI5hsYorZqGyTiwYQ==
X-Received: by 2002:a05:600c:4f50:b0:4a2:1050:aff with SMTP id 5b1f17b1804b1-4a35ac8c32emr168076125e9.6.1793026693314;
        Mon, 26 Oct 2026 07:58:13 -0700 (PDT)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a08643dsm158480615e9.4.2026.10.26.07.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 07:58:11 -0700 (PDT)
Date: Mon, 26 Oct 2026 15:58:08 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Breno Leitao <leitao@debian.org>, chris@chrisdown.name,
	Sam Crossley <samuelcrossley@gmail.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Simon Horman <horms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] netconsole: allow replaying the printk buffer on
 demand
Message-ID: <at9qgBucVm-QHnye@pathway.suse.cz>
References: <20261024-netcons-replay-upstream-v1-0-9613f38496e5@gmail.com>
 <87fqxskdpl.fsf@jogness.linutronix.de>
 <at84qygscue8crQi@gmail.com>
 <87a4o0k3qa.fsf@jogness.linutronix.de>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a4o0k3qa.fsf@jogness.linutronix.de>

On Mon 2026-10-26 14:15:49, John Ogness wrote:
> On 2026-10-26, Breno Leitao <leitao@debian.org> wrote:
> >> In the per-console loglevel series Chris Down introduces [2]
> >> /sys/class/console/ to sysfs. This is where we would put all the
> >> upcoming per-console knobs. I would expect a replay trigger would fit
> >> well there.
> >
> > That makes sense from a design perspective. Thanks for the direction.
> >
> > So the next step would be to add a basic /sys/class/console/, similar to
> > [2], and put a `revplay` entry in it. 
> >
> >
> > That would be about three patches:
> >
> >   1. Create /sys/class/console/, similar to [2] but without any loglevel
> >      handling. cdown can build on it when respinning the loglevel series.
> >   2. Add the per-console replay helper, similar to [3].
> >   3. Add the first entry (/sys/class/console/replay), which triggers the
> >      helper from patch 2.
> >
> > Is that what you have in mind?

Sounds good to me.

> Yes. But perhaps someone else wants to provide some feedback about this?

The "replay" approach looks like a big hammer. Many messages might get
duplicated, especially when the outage was small.

A better solution might be to do not increment con->nbcon_seq
when the transmission failed. And try it later again.

con->write_thread() currently does not return anything. I believe that
it is partly a historical limit. Two problems come to my mind:

   1. There used to be a global "console_seq" counter which was common
      for all console drivers. But we have a per-console counter since
      the commit a699449bb13b70b8bd1 ("printk: refactor and rework
      printing logic").

   2. There has never been a try-later logic. But is should be easier
      to add it now. We have the kthreads. And even the legacy loop
      is able to break when there is not progress.

Best regards,
Petr


> >> [2] https://lore.kernel.org/lkml/84b8d91693e56f6026271bc40553bcb6657ab24d.1764272407.git.chris@chrisdown.name/gy
> >
> > [3] https://lore.kernel.org/all/20261024-netcons-replay-upstream-v1-1-9613f38496e5@gmail.com/
