Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E843CB540;
	Tue,  8 Sep 2026 09:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860059; cv=none; b=YN3LPCe1bhHb0D0ARYOO2SnAyGswRnYaGjHrLM9P9YSUE9uABdsQlvFvkipXnrdZpaFpcgvV8B3D8vvd1SP56/MI0wxNCg0EQiC4/Jjt1Xm4JBlETbOXaMQicLU7wF9vGnB2sRSW8iS1eykhKMxArzlww3cmvKjIgtS5TLyKOPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860059; c=relaxed/simple;
	bh=fjdbg+HCU2qxrwaR7lo/p3ulijKZL0z3QYmLV8+ahKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHXPepqjVDkuUEkYetURJZyiBrLOKE4GmU5+Y1yq1tCvJLO3EU+RhmssQY3JdpiyjeWYxfZdyZZhgR4mX+MUE6PTspSLyBIolpyucCpeZC/xDo+YeIkwL4hVNLmbTPgiwrM0J8h4jZuAzBzaUYSW13r6IcGTk/20yZF2s2imaaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oO6CdAq4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oO6CdAq4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46EF1F00A3A;
	Tue,  8 Sep 2026 09:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788860057;
	bh=sn0B+07X4/4/8Tz4orPX57lBjTzDwNVTfmimWBkfJco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oO6CdAq4YNnjfKtB2opLcT6Y5D9Mx7IM2llNbQdWAHorw3nHt3n8kaGfiOLWwIvfh
	 ypOvTMIo8l5uQj7xNP/O5a5/kNJL4Zvnqk/o41JJGLDTkWgDSvhnb28UWgeWA7pfN9
	 BOJDVRJvQ4u6eDMQbXc1/JG9ASS7KXIXgDtIIruEadpQkN7EVd1tgeCuOAdtk0kkYP
	 zvcCqqwwDmTUya7V1hUThgNNhHzn3cHgawYuQAyR3mOxRiRQhVh3i7DxIjaNuDaLn7
	 6ln2oGbCueGEB08E3ZgpQczfHOv4fGu3TChSmE2nh5qwGkmYHwe7icVlYk9wIZpAD/
	 JkyeuIhDWnugg==
Date: Tue, 8 Sep 2026 10:34:14 +0100
From: Simon Horman <horms@kernel.org>
To: Chris Gellermann <christian.gellermann@codasip.com>
Cc: bongsu.jeon@samsung.com, david@ixit.cz, netdev@vger.kernel.org,
	oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nfc: virtual_ncidev: Add missing ioctl compat handler
Message-ID: <20260908093414.GQ40544@horms.kernel.org>
References: <20260904164252.18351-1-christian.gellermann@codasip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904164252.18351-1-christian.gellermann@codasip.com>

On Fri, Sep 04, 2026 at 06:42:52PM +0200, Chris Gellermann wrote:
> The compat handler for ioctls to the virtual nci device is missing. So,
> nci-specific ioctls of a compat task return with -1 and errno set to
> ENOTTY. Add a handler.
> 
> The handling of an ioctl() call of a compat task to get the index of
> virtual nci device (IOCTL_GET_NCIDEV_IDX) lands in the default case of
> the ioctl compat handler (see fs/ioctl.c):
> 
> COMPAT_SYSCALL_DEFINE3(ioctl, ...)
> {
> 	...
> 	default:
>        		error = do_vfs_ioctl(fd_file(f), fd, cmd, ...);
> 		if (error != -ENOIOCTLCMD)
> 			break;
> 
> 		if (fd_file(f)->f_op->compat_ioctl)
> 			error = fd_file(f)->f_op->compat_ioctl(fd_file(f), cmd, arg);
> 		if (error == -ENOIOCTLCMD)
> 			error = -ENOTTY;
> 	...
> }
> 
> There, do_vfs_ioctl() returns -ENOIOCTLCMD and compat_ioctl is not
> set for virtual_ncidev_fops, i.e. f_op->compat_ioctl == NULL. So, the
> ioctl() syscall returns with -1 and errno set to ENOTTY to the compat
> task.
> 
> To fix this, use the compat_ptr_ioctl helper for compat handling here.
> It shall be used for ioctls that "either ignore the argument or pass a
> pointer to a compatible data type". The driver's sole ioctl takes a user
> void pointer and copies nfc_dev->idx to it, a 4-byte integer across all
> ABIs.
> 
> This issue has been found by running the nci_dev kernel selftest as
> rv64 binary on top of a CHERI kernel, where the ioctl() ends up in
> the ioctl compat handler, similar to a 32-bit application on top of a
> 64-bit kernel.
> 
> Fixes: e624e6c3e777 ("nfc: Add a virtual nci device driver")
> Signed-off-by: Chris Gellermann <christian.gellermann@codasip.com>

Reviewed-by: Simon Horman <horms@kernel.org>

