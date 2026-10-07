Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA5F27E1DC;
	Wed,  7 Oct 2026 21:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791409674; cv=none; b=itDpNNi78utcstZzRHyjkjJlRwhPKUAhNug6/10tPOGdCjsJGmj+9I4rNWfzJhokJOXov9TqwRQ5hcxHFhM00syXn52BivdS0ArDlRUlDDxoMhAQLTMHN2RA9QPZrECOT/lz0rjL7YazOjJqPEKX6l8MUQKSbfFn8qUY5HhidoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791409674; c=relaxed/simple;
	bh=iCuEgTy3fWk8SL88SbuVaHRBc8KZTRoMUnGDJiOoXMM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VUv3yIqZGPOtZvOvaj0LOGOdl3LZEivqS2jJvPRMLbpjDQdJyjkR9jWV1hE16N0Xo56uoQuWzAQCpggJndyN9tgr0mTvcXnw+XBaPHIMMlABNR45cuMo09OLzJKd8x9FZwqqtuHQ6zzt+9h5zB1ha7eDg/7QNQLupomvAdBE40E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0zFdIRi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0zFdIRi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F08F51F000FF;
	Wed,  7 Oct 2026 21:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791409673;
	bh=ZZLzBrm9AgpobsusQS1OCG+MADJektCGs465QeVYBJk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=f0zFdIRinkfZRcKlHGvTCQ24VejwnRSrAPssUQij3ZaEtVV9hF57pF0C1BOYlOD9C
	 Poh7UJ5X8OgR7l6/ujHwqBMQSeUwlEW2yieO51cfYFy21lu8UIYPvYsvyHJHri7lSL
	 NnmgxDw7eBM9PwX1pu0ARYqaKeJq2UpDBAtn5f+E8DMkRY5SX6BFFQJhemPhA0hZU7
	 8dapqwbcl1fZ4U9RYPfNEE4Yf2J5v2pIMneMOuV5rlBUW4rHn4hd645v3XXzjzdESa
	 YWtq4z9a9UhVwrszEzX7atU+LcVa3ZIy1mCffnIH/nmEFirSp2U4Z1CP+1JEAAiXZw
	 ruq17fWQVZ9AA==
Subject: Re: [PATCH net v2 1/2] ptp: drain virtual clock sysfs operations
 before unregistering children
From: netdev-bot+sashiko@kernel.org
To: james.hilliard1@gmail.com
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, yangbo.lu@nxp.com,
 edumazet@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org
Date: Wed, 07 Oct 2026 21:47:52 +0000
Message-ID: <179140967248.434549.15357420235192842364@kernel.org>
In-Reply-To: <20261005-ptp-vclock-sampling-v2-1-8ed12d4d10af@gmail.com>
References: <20261005-ptp-vclock-sampling-v2-1-8ed12d4d10af@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message gives the wrong reason for the
  is_virtual_clock guard in ptp_vclock_remove_sysfs()…

--

ptp: drain virtual clock sysfs operations before unregistering children

This commit removes the n_vclocks sysfs attribute at the start of
ptp_clock_unregister(), before the virtual clock children are walked. Doing
so blocks new n_vclocks stores and drains any that are already running, so a
concurrent store can no longer unregister the same child a second time.
Virtual clocks skip the removal through an is_virtual_clock check.

> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> index dc398c6b75284..53388b1231980 100644
> --- a/drivers/ptp/ptp_sysfs.c
> +++ b/drivers/ptp/ptp_sysfs.c
> @@ -263,6 +263,12 @@ static ssize_t n_vclocks_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(n_vclocks);
>  
> +void ptp_vclock_remove_sysfs(struct ptp_clock *ptp)
> +{
> +	if (!ptp->is_virtual_clock)
> +		device_remove_file(&ptp->dev, &dev_attr_n_vclocks);
> +}

[Severity: Low]
This isn't a bug, but the commit message gives what looks like the wrong
reason for this guard:

  Virtual clocks have no such attribute and must not remove the parent
  attribute when being deleted by its active store.

When a vclock is deleted from the parent's active store, the path is:

n_vclocks_store()->unregister_vclock()->ptp_vclock_unregister()->
  ptp_clock_unregister(vclock->clock)->ptp_vclock_remove_sysfs()

Here ptp->dev is the virtual clock's own device, not the parent's.
device_remove_file() only acts on that device's directory. It cannot reach
the parent's n_vclocks attribute.

ptp_is_attribute_visible() also never creates the attribute for virtual
clocks:

	} else if (attr == &dev_attr_n_vclocks.attr ||
		   attr == &dev_attr_max_vclocks.attr) {
		if (ptp->is_virtual_clock)
			mode = 0;

Without the guard, device_remove_file() would just find nothing and
kernfs_remove_by_name_ns() would return -ENOENT. There is no self-drain of
the parent's attribute for the guard to prevent.

Could the commit message say instead that the guard only skips a no-op
removal on virtual clocks, which never have n_vclocks? As written, it
reads as though the guard is what stops the parent's active store from
draining itself.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005-ptp-vclock-sampling-v2-0-8ed12d4d10af%40gmail.com
