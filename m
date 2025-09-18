Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63DA22FE0E
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 12:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758197570; cv=none; b=Qvbz11UysQCUoWlZYUjKqssG/elrU1DkwTZicimhNTLg8KQolKBYtzo2illo8v5em90GPnFoAYDqo21k0q3zooG8PkIO800rWja9ruzdPAIEh4Y4kJRHKk0ZhlTYA8w2WnwsF2swclxURrHgei4gjT7Xq4COGBvL4SkvTJNlLas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758197570; c=relaxed/simple;
	bh=3AuDQOb4x5iPQKA8fJMnmCnY++4xw9SzQPwxbDEjEO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlMbAd+cm7fD8cVZvv6I7+HHKNy5/zya5I7hWAhd8F3A6R/4Iz5fCDCiYj07Sd2J1wrJsAco2MA6vLsrt/KhKyfZ3qcy5dCeSNHJp//jIGsBMDlfx+cfENT6AmKNGDK9f9eSHUorNNh36daW/dULndglbc5lyLPm+CB8d0mztts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=g1iFMGLh; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="g1iFMGLh"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45df7dc1b98so5558615e9.1
        for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 05:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758197566; x=1758802366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BWX04E2Uyfnl0/MdQ83kX9KCxuahZoS9QnFEedx1B1I=;
        b=g1iFMGLhBdzHGXMZ9VMTjgBRnD2aLwTrP7nJSP3UY1F6DU5408sbnwbNfT/xgqjzNw
         MQVDsNAwgLCtFT6scdmuM9eOhEu6Zlx+C51fbZvrMfis47p8Jux4KHldBDAVurlGB1lN
         65Q36IxCSSI2+eMzv5bxpAzO3gPoFy/WcKb1BTphkOdIFTDvQhm8yOwbyT6Y2z69RiXJ
         wB/chwaSD4krqOQcrbamo2uMJ+l6azrlt1i0XzlaejgsGWSD8I/rfcAFkuJVppxQOHRv
         5+ZQy+i6lUeP9MOm6guBzzBI4R/KCUP0HEH/lK/3nr3OpwpqiyQHe6bvER4ei8UmlkH/
         tD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758197566; x=1758802366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BWX04E2Uyfnl0/MdQ83kX9KCxuahZoS9QnFEedx1B1I=;
        b=iNlzQ2QRVCmffQjocE2W5My+vosoAx+aBQnyFNDlQVz3YfyyMeTIKijXeS/g8EREhR
         4v53fRCfEGJUwr2goeLWQcXUWys1RmaddDhLxGdB99WahpMR6jhUZ/mgWfT8Tsgn6mMo
         cgUKmFVXdCYUDZfZ9Rd2WEJ6rQ7ymLOK6BG08kbdjb4vGPdNIn4UXgT6T+NKXGQhAUMn
         rACTtssvqYytHMl03VUhtqeAptXCW4JWtl+s27nZPyMjngX25G0lQlxj3KmAeXbRmHET
         zGAK9PMgvwQu6dPYYE5NtcF9t2m8UIEpuRDWZQOXCiUuXjZPF3qtTXnKLZreDUQ0hlFw
         FIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCX52WzyGY/sq9ke782v6YcfrkVEAslyO1joUE6jMKH0E86Z8GSqKZzQQF1yEst77weVtjlgwFc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXMnoZCojQPcspJ4wvV6+mp4p78LcbduEIZ1JMGJ42qBYfdRib
	m+YgTfLV6Xp+ulZ9Mllg70nBTQiqVgIIxEEVh+1+42oGupCbEUYEiaJHc1BJtwDhZqk=
X-Gm-Gg: ASbGncs5xgZfSOPV49GdMcHy+SbWbdAJlId0C4nP6XcAprpMlLd7EllNivPrWwhYcmo
	Fiz3hiTHMZ9q4uX4S/WyMXxb75hHGqFUy/crRMTWvjD0trZPFHg6qHg+eeOdOa5FD0RqGGnLuG9
	W13EeNFtZoRKBxW/20ztbGZLD5B04J1xFBxP0a96TrhyaF9K3cuiZOpLoXKaYZdk7bNY8x+yvrm
	g+NqmNYuarzkpSnGrnYT3QB6GN0SEXqX3q/82SQAP4dHZYJObkzigjOmEd54xe8tpNBrtCqg8xu
	p2IT3trFx3yntVCtz+f/ZgUsXFFoCmn3LG865/6bkxVrCq/CtTBToJ99kBHd6yf5W7+n1ljm10t
	3s4j49XLVelHAd9ulukM1XT40u8HLKVLSM7QYSDdFitxa0qpq+NAKEnVC+Q8bTCkFXfhZtPAG
X-Google-Smtp-Source: AGHT+IFC0tUTZXRyDtSx9d5omtvQ0WqRKqIy7a/GY6qAoByd5UMfWoRhcJw9UPFcqNlY7Wi3YHh+QA==
X-Received: by 2002:a05:600c:4692:b0:456:1824:4808 with SMTP id 5b1f17b1804b1-46206f04fa0mr48803915e9.32.1758197565947;
        Thu, 18 Sep 2025 05:12:45 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f3252260csm64513315e9.2.2025.09.18.05.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 05:12:45 -0700 (PDT)
Date: Thu, 18 Sep 2025 14:12:43 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>, 
	Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, Mike Yuan <me@yhndnzj.com>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, Lennart Poettering <mzxreary@0pointer.de>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Jakub Kicinski <kuba@kernel.org>, 
	Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic Weisbecker <frederic@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH 14/14] ns: rename to __ns_ref
Message-ID: <3hwzagok7cl3sz4x7wi7z4xwme54y3pyljfkqfjrbkjrbdlyih@rodvre2ii7f6>
References: <20250918-work-namespace-ns_ref-v1-0-1b0a98ee041e@kernel.org>
 <20250918-work-namespace-ns_ref-v1-14-1b0a98ee041e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d2ckcju6bogfsla5"
Content-Disposition: inline
In-Reply-To: <20250918-work-namespace-ns_ref-v1-14-1b0a98ee041e@kernel.org>


--d2ckcju6bogfsla5
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 14/14] ns: rename to __ns_ref
MIME-Version: 1.0

Hi.

On Thu, Sep 18, 2025 at 12:11:59PM +0200, Christian Brauner <brauner@kernel.org> wrote:
> --- a/include/linux/ns_common.h
> +++ b/include/linux/ns_common.h
> @@ -29,7 +29,7 @@ struct ns_common {
>  	struct dentry *stashed;
>  	const struct proc_ns_operations *ops;
>  	unsigned int inum;
> -	refcount_t count;
> +	refcount_t __ns_ref; /* do not use directly */

+	refcount_t __ns_ref; /* do not use directly unless initializing */

Or a helper macro like
#define NS_REFCOUNT_INIT(v)  .ns.__ns_ref = REFCOUNT_INIT((v))

>  /* cgroup namespace for init task */
>  struct cgroup_namespace init_cgroup_ns = {
> -	.ns.count	= REFCOUNT_INIT(2),
> +	.ns.__ns_ref	= REFCOUNT_INIT(2),
>  	.user_ns	= &init_user_ns,
>  	.ns.ops		= &cgroupns_operations,
>  	.ns.inum	= PROC_CGROUP_INIT_INO,

The double underscore stands out here.

Regards,
Michal


--d2ckcju6bogfsla5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaMv3ORsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiRfAEApv9CrJao8D2U3nthYItW
n4Mj9Y9Wuj/jH8AzHvpRZR8BAPgIUuzR7g9w7rnCTqM8ybuEtlMzNEwUPf5cGz0m
vFwK
=DJVu
-----END PGP SIGNATURE-----

--d2ckcju6bogfsla5--
