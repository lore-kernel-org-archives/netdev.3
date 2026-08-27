Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BA8379EE6
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 03:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787801140; cv=pass; b=STlJhsx509d9n/5Gz9FzNtAXiq173XJp4v7sNIUMJAAsPUUYIEEpESPkxQj+zjoDnge8LO6M8GntCoEbia569s1Oj5T0z0RpRTKSbP4xneSvuOiT1qH8rk72kszK75y3KWdskpbF71+DiedEzh2xDUiGA4GHU5wTr/d9k1idouY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787801140; c=relaxed/simple;
	bh=g54itBuxSGyTv+TNAUIo3lSrFxdYUvWmXIkBOCtztfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tdS5DUg+2/SxDWxhL6AS7RvvV/5S98NvqgH084slMaz82S09BIeNQ/gZQkv5EM44WqQeXADfqVEYu4RR4pFmb0c0TK+Eh3WEge2UoaZalZpPELJ3wQrRr2+v1eAfR8MI8xddrG9BpzbhV7XLablb3VLR22wamM3iwCF6mz8v/AQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeViQMlj; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeViQMlj"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-396afefb35bso33364a91.2
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 20:25:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787801138; cv=none;
        d=google.com; s=arc-20260327;
        b=qOrQQzu8QuwZ8jvYtWbwPiWhIfCRPmLfUaYNNsv1POf6nr50HQq5Dnxf0VeaXJMoI3
         c0jAS9ZorpnGlgXQZVFZxu/vwymosF+syq4UuVzwhx82L4eQ1Ad4MuI/i5sxTZxUtvEw
         WHYkKwgYCPsF/Gcd90Ccj+41gAsFhrAt1paPU+3iPeOX+woz8w/iFStKvWsf1zVUDKCI
         ZevuZ3MyntnYYGP533CWVXQUhRSkF//5cnkFUAut0FflpUQVD26QuX+GUupkGKCplohX
         In/lRqzNIY963fBufTV0hCsPTklUFfRcRP2XK5S6MLjiJ7ZlXdar0iqzJuFGfYWoHefa
         T1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y6tDIPKS/uqXuuUFnPzqnQhBgbsl8522wLxb5JPJ+mQ=;
        fh=Yqg5r+cegAWdYVICdVgfILwUIo6UkDRsbpXwvpBVvBo=;
        b=TQInnSFwxzZ2rrLNA6+Q/8emQNOVChE9CcyM+dRginXabwWc+AnA6wKwE2UQefmxY2
         HOtmrfstjZPvIpBp09rxUVyE4WuG2z+Akx3t4Z+hwZM7YyGQB14nke4v2dgj1v9S3Cr3
         5ol8P/B95GEyvKQZE0bg7WfH/gPe2u3CZ9BbYGos+d4Exms/G0Jxprx3PWl5PF8w/DIe
         g64U2a6vU4d3Pw4XWEdG560vdYbsPXR+uY1MSvTTUSRONshaw/NcbbF6zTS+tCy466LF
         ZM2bCmGu6Z7VirMB7KpghXF1im7xBhCQnBbEZqc8cgg890CdDZKLsiPSHdzVuAIiN37A
         bvvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787801138; x=1788405938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Y6tDIPKS/uqXuuUFnPzqnQhBgbsl8522wLxb5JPJ+mQ=;
        b=EeViQMljhcvK+BJjvzeRTbaTkGuVC1cxbaW+ykbBaejdPoSA/4+WZHw6VwKv8E6FoP
         vobt8Mu3opgs+l3yUhlszPHAzu1zWq6g1WkMIVUfEVgO9LKraXp7k8qRZ9uw1NimXUbE
         UtpLCMIWLkGWJUZ89lrOARkFU++vkosIOMQsHOGuy0zlwih9qJHhIkrS7Q5SP3bi0nes
         ybzXVjOe+Zq58UmhQ1E2ykj9lUUWebxw+CiKU66wQUFodfmasrvvBwicshYe/hGjXb5J
         HuG7w9tnAhJzazGTSJJZNfWZraCqgIGfw3olaCXMoY5qvCz2u9dn+q+9Ws+p4+k1JZ9+
         2AKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787801138; x=1788405938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y6tDIPKS/uqXuuUFnPzqnQhBgbsl8522wLxb5JPJ+mQ=;
        b=BtU/rB1AqfuaxwqIScyW0xYXk+SXNjQ7DaeGrhxG4TmNwBTqQC5BIZqV+hgnsZCNhq
         bRknDP8nWRHM8PMMtZA5IDWcfwRcmWEZ1Jyfdw4hMRaJtAm4ce5uY4Z88tC7LSxW3i6G
         JowOOROZvcB9obzG/i647Nq5QhLLFwjHxgl2XmZu8QnehLR1khkIiibtOcL6No+lwjDP
         7gwF0YhY79vxyASvCpxlSM394nShQQJ7o1k1DSCzdbRWHBIGzuOLdE8JNTHnbe8KR0s2
         sEyvcqElSHEYZZdTHrrQ1D5CqjqBtk0GXfNdHvcqTD80/thd+7zYUx1iCUXKQByTxC2y
         yl0A==
X-Forwarded-Encrypted: i=1; AHgh+RrWqfKF6+7OvFZnCy6wHa+QeEeWR70tCkWrqu16H9IgJvhim7NxWdeGAdPsj9w8c4/AYlJPbRc=@vger.kernel.org
X-Gm-Message-State: AFuF++kszdPuJSSfVl+svk2HLxzxoeOWJTceozfcZP+S5cufaTHuPa+k
	x1z+zsMsRGzxeBsTClXLWGG4UhWtz/teAa8HboD0ZcMurZYIjyUCI6TKzaimkk1mbjOnpsgLJ1j
	QR/jG1zpiy/1XMz4nNY/nDjNjhYCFUDc=
X-Gm-Gg: AR+sD110aYmO+m4ds5fw21+hPjifvWwjsngyo6X+UsOpeo4t27HOzQQE+agxczznb0/
	WtN4G4vNhLbyAfHC61oiY9BGdyFn9yCa4wjg0z3PSeFS9kjbE4XbGvfWR4tyhmYpE5eZRiSeU5s
	ejg5NW59uWlROIZpOXU98RwEmM953xkd7d6OIyhoea6ONTgFJLR08GBRm8f0hh9z02wsbsV6QHe
	d31z/NwGDBxBZCDCMk/CvHkuGhA1O5lZe2+IigKou2okdusaBYnb8tmOI0or0XSP/CYTqGiAmNO
	hroKGr29CBkSB76Qw5LhcrKZQGeq3O/uSM45Fv6Fxpxf43l3b8n5k2ciZ2WJO7d5lmw6ymNHBaE
	lIr1UvSnQ2MBwA9yNJA5t47rv8sEJl34NfBlrW5uvzu3LPQ==
X-Received: by 2002:a17:90b:5890:b0:38e:ab3f:2c99 with SMTP id
 98e67ed59e1d1-3969784322fmr4319785a91.2.1787801138078; Wed, 26 Aug 2026
 20:25:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com> <ao-OhAl-Mys6zU25@fedora>
In-Reply-To: <ao-OhAl-Mys6zU25@fedora>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Thu, 27 Aug 2026 11:25:26 +0800
X-Gm-Features: AcwNN1UsW2jM8ssQQpvcbBQcH5RsqQMruPr46XEBnGMCtC1F0gnCVtmZRBd-LOI
Message-ID: <CAH78GvupXnEHuW_MW=19u2yAw1gHq1+wnpdtUYKLGp3eS1jhYA@mail.gmail.com>
Subject: Re: [PATCH net 1/2] bonding: reject frames with insufficient headroom
 in bond_header_create
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: jv@jvosburgh.net, jiri@resnulli.us, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, netdev@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hangbin,

Thanks for the catch. You're right, my wording was inaccurate. This is not
about an active slave switch or changing the bond type while sending.

The issue is a hard_header_len update race in bond_setup_by_slave(). An
in-flight AF_PACKET SOCK_DGRAM send can snapshot the old
bond_dev->hard_header_len
for skb headroom reservation, then bond_setup_by_slave() updates it and
installs a new active slave. The existing send path can continue after this
because dev_close()/dev_open() does not synchronize with already running
packet_snd().

Later bond_header_create() uses the new active slave's hard_header_len, whi=
ch
may be larger than the reserved headroom.

For the first-slave case, the bond can be slaveless before enslaving, so
removing existing slaves does not prevent this window.

Thanks,
Qihang

On Thu, Aug 27, 2026 at 9:10=E2=80=AFAM Hangbin Liu <hangbin.liu@linux.dev>=
 wrote:
>
> Hi Qinghang,
>
> On Mon, Aug 24, 2026 at 10:18:01AM +0800, Qihang wrote:
> > From: Qihang Tang <q.h.hack.winter@gmail.com>
> >
> > AF_PACKET SOCK_DGRAM sends reserve skb headroom from a snapshot of
> > bond_dev->hard_header_len.  A concurrent bond type change can switch th=
e
> > active slave to one with a larger hard_header_len between that snapshot
> > and bond_header_create(), so the slave's create() pushes or writes past
> > skb->head.
>
> How can bonding change its device type while still sending skbs?
> Bonding does not allow enslaving devices of different types. We have
> to remove all slaves before changing its type.
>
> Thanks
> Hangbin
