Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB5862809
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399236; cv=none; b=DBY8ODiD91pCeCoJVHA6eVlWX9Ie9lQNDXg7N3Cscb7xzoj+iZbiLeYW12KtHfjUfjbZhMroyLHs7Zbx3AHKcLE2ZaHN3hvLGaX4nzHgld8bx9NBO0Vyk+gIGdoT7UxbCeX5EFXnvUAqTxW61Q3VJgtOYGoh/MM7VxbUzyjktQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399236; c=relaxed/simple;
	bh=vrS0RV7424gT0I283K6akodv4liM78+AzCZHA48Ok6Y=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=ksvX8Le3PwFGJFp9/51gMihxtyE+4hnAjzKaNDPDukVWGDLhhZXMW380vwLn5BTrPE39CBr0XnItbL9u7ZQcqCM9r8GL9oikqJERK/4sEHzWZ/0VB3PKKoyyJCg/8jpbw/1AYvrr41m33S3gS5bvsdK2Sq2WDuJbS66bj5QF4Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=xMONduS/; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="xMONduS/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D6406A0334;
	Tue,  2 Jun 2026 13:20:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780399232; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xUVUTRqCxDHPUZM4nyM6p+a79DE4JFuE0oGDHqGQwzk=;
	b=xMONduS/Mg01sVtBZ7u+zQ7eA6DPGhK5hAZrgzIg8gaGAp8xJAu6KoXdVBwjiam2M7Y7nG
	mehdoKb1PgO2ZBTe1Sb9kxW6nQtpu4+7XLC880avgZ6hf6/5O9Wfa0tMSUlLPQGKrcnwUC
	PjSCypcewK5XBjRLnnHpbZIZjuYujPneARZtXiksCK9cy/fcT8NPY330I5QiXq60s3baks
	tRgqx0vmvgiLQKKVgXlKIu3r5WlSL1B4zbdBnka48amxagLqLes/aK/6xGLiHbpd/nW+ED
	9nDtu+P34v4x2ON1M6oFjPwJGf+QMHuXVftddV5gaYmXoSM6ZRa/5oz5XUUIPA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 02 Jun 2026 13:20:30 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
 netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, michael.chan@broadcom.com,
 joshwash@google.com, tariqt@nvidia.com, haiyangz@microsoft.com,
 linux@armlinux.org.uk, maxime.chevallier@bootlin.com, willemb@google.com,
 ernis@linux.microsoft.com, sdf.kernel@gmail.com, kory.maincent@bootlin.com,
 danieller@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next 02/14] net: ethtool: make sure
 __ethtool_get_link_ksettings() is ops-locked
In-Reply-To: <878q8x5mip.fsf@cloudflare.com>
References: <20260528231637.251822-1-kuba@kernel.org>
 <20260528231637.251822-3-kuba@kernel.org> <878q8x5mip.fsf@cloudflare.com>
Message-ID: <34fad14a092e28c3512f2405f0869133@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub ^ 2

On 2.6.2026 11:17, Jakub Sitnicki wrote:
> On Thu, May 28, 2026 at 04:16 PM -07, Jakub Kicinski wrote:
>> __ethtool_get_link_ksettings() is exported and called from sysfs
>> and many drivers. Looks like commit 2bcf4772e45a ("net: ethtool:
>> try to protect all callback with netdev instance lock")
>> missed adding the lock around it. Not treating this as a fix because
>> I don't think any driver cares at this point, but if we want to
>> remove the rtnl_lock protection this will become critical.
>> 
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

> [...]

>> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c

> [...]

>> 
>>  /* Internal kernel helper to query a device ethtool_link_settings. */
>> -int __ethtool_get_link_ksettings(struct net_device *dev,
>> -				 struct ethtool_link_ksettings *link_ksettings)
>> +int ethtool_get_link_ksettings_locked(struct net_device *dev,
>> +				      struct ethtool_link_ksettings *link_ksettings)
>>  {
>> -	ASSERT_RTNL();
>> +	netdev_ops_assert_locked(dev);
> 
> Not sure why we're using the "compat" assertion here, which falls back
> to check if RTNL is held, instead of the newly introduced
> netdev_assert_locked_if_ops().
> 
> The contract here is that all callers are expected to hold the
> netdev lock (if needed), IIUC.
> 
> [...]

AFAIU that's on purpose: the original helper had ASSERT_RTNL(), and
legacy callers still enter with rtnl_lock via the wrapper. _if_ops
would silently pass for them if rtnl ever went missing.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks
Nicolai
