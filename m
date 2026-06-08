Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73F533BBC0
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 23:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780962015; cv=none; b=QOuMuJVmhJGML4iZMa321rf1QdGhS7fWV581+ZpYIKky3l4lZLLghHDhSFqBRQkjMK2PUTCrfu0VaZ47hsPyAGxQaCEfcsFD+BUsnUoPDeNpbYqnB5arO7XPAvUSs0Fo1BTa/PUPndYKL1eL3lCtDJpSbZhOZzo5LHvviq6Zwa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780962015; c=relaxed/simple;
	bh=LWbDo1tNpzRF2EJu64QC+xXYbrCyN7SQkEugWAL/E8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CU/9Hq9YCW6xBvVCNh2BHQ/XCAIXeoD0fpVlyxK+yqdv5AFew10J/Qr1Q4pTzgNy5V9t2fpBV7Z7yGw7iIm1Fx3aNeIzf8L+8GK2dtE+Z6S8hwtFJmB0PKubcTDuvuin4pIGcfiKq6nCyvRN78Ae7rJ5FpKTxeTo0UmEfQyQtJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io; spf=pass smtp.mailfrom=multikernel.io; dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b=cDr5WnBo; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=multikernel.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=multikernel.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=multikernel-io.20251104.gappssmtp.com header.i=@multikernel-io.20251104.gappssmtp.com header.b="cDr5WnBo"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-304d7f31215so4221955eec.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 16:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=multikernel-io.20251104.gappssmtp.com; s=20251104; t=1780962013; x=1781566813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K4g/DRIeQmhcF8UCSnDGYAaCviFQymkXojIEQQcx2DQ=;
        b=cDr5WnBoxwskt+uF8rdkxJg6OAbRKXF7LGsFo3obP37Cr7Kw+G0ZdlGNig+xaUgxjG
         4SVcSXz4aMdxQYKhRecC1MuqcZSodRu/yRGKktTCgU6rXrGHODd8LxdeLs/HZOfz5C6U
         B+RZ3PwY/wq9mffEUp4n8b0Dt6TwqOgHv2FaEccq0bqgeOCjzeLr4OPC9InzgzHkNTBd
         hzKGQR58lle7NmJxoV2m2u5NF8wlDTqRDGPfEWOvAvMt7/MQr8CUJCY11dECx2R9Le20
         xHEC/mrA8OgEVj3VUsc4rB7VE2ZGe79YlcvBNNRKwhO/uTLnQpDv6zthkSwoy2gzlMpJ
         bzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780962013; x=1781566813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4g/DRIeQmhcF8UCSnDGYAaCviFQymkXojIEQQcx2DQ=;
        b=fQP/ydFPndvLD/ZWInm+HQz1UAkz+VhiXZACjBGEHnB9zwQ1HuqEFPBnz0o3xGoOp5
         DuyTR49/j8hl1R+Zd3XSe4s9cKwoep9TmBaBa6OviMnjkJUCt0syBDJAjiPcKNz++ZrF
         4RXLfUjqfolsd2q8aIB0uC8h8OCyx8tbGCkO7DJtQjyVo5YlywMn4e4DuL2icSgXZ3W8
         g5e2w/U0VpOgC860XQyWi5As64RJWgESHvgRRPeEVDjLwdp3HMy/5a956IvMK+0PG0B1
         LJnzn/1kgEOv5lPp8F/dDeyuPFzWMx9cDzbqcO2O3pATWWxJt2MhpnhctmYbsul/VzfH
         C+oQ==
X-Gm-Message-State: AOJu0Yw8IX1FG48OnmBysI4uTubK8bJNxfoK09rNhYrd/NR4+EiTkXTL
	9d2ZXRgiNo18ioeRceqnWvTbsau7ZZXxezAtTyZn7Yz9nBbDNs9xuLk2yAYybw6oRb4=
X-Gm-Gg: Acq92OEfiPTzGFtCHU++l2BVXF2KfvMMo3ZjeP7QA0kmj07DRD9Hcqit119cHmEHtky
	BDH7FkTvsGLH1+GIIX4QRAxeBaFL/WK5bx5HNC43Biv+kb3PvFUaDBpTnBEv8zZwM6ysO0TNcKJ
	Dr/w0L6FwDu0PaMvtAzjQHuxm9sBKfqQxHhZnvmLcKhHSrbQW2AcYBxZgS7iJAGw7Ex5r5qH5in
	e3Ee5ODi3MZCzKF0KVuWH1fy4mPCNWOJ9/5K1WciCBF0p9IpHqX3qCgNO1p1mQL+RPOyeUgghTL
	1QOSxne62nHHfaOD5G3h+l1BQpE84ySSyzuwLBR839XNKE63d/ffz4hjt0V8TooTFKtQT8nD76b
	d7/MF0CXOYzeDNMxRZX6y72Qzq3uRZZBuCnj7t1SvJu0D+vZ8WauGJKtfv9HxdfIuyd5fgqSLeJ
	YMsgbYSrru6awKC/sp9e7Am3yoQH+l53Tqz9sNJPJk4LYjXbvi0mwGOzoja8GJaSYf
X-Received: by 2002:a05:7300:2311:b0:2f2:6dde:df66 with SMTP id 5a478bee46e88-3077b5a13cemr9177580eec.22.1780962012759;
        Mon, 08 Jun 2026 16:40:12 -0700 (PDT)
Received: from localhost ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074db560d7sm26695452eec.5.2026.06.08.16.40.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 16:40:12 -0700 (PDT)
Date: Mon, 8 Jun 2026 16:40:10 -0700
From: Cong Wang <cwang@multikernel.io>
To: DrRac27 <drrac27@riseup.net>
Cc: netdev@vger.kernel.org
Subject: Re: [BUG] No cgroups in network namespace
Message-ID: <aidS2sxy0c_Qhh4_@pop-os.localdomain>
References: <e69b2aeb-0fb0-44a3-89b2-e4ddee16dbf2@riseup.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e69b2aeb-0fb0-44a3-89b2-e4ddee16dbf2@riseup.net>

On Thu, Jun 04, 2026 at 02:47:14PM +0200, DrRac27 wrote:
> Hey,
> 

Hi,

> 
> I think I found a bug and wanted to let you know. If I create a network
> namespace and enter it using iproute2 I can't use cgroupfs2:
> 
> $ sudo ip netns add testnetns
> $ sudo ip netns exec testnetns stat -f -c %T /sys/fs/cgroup
> sysfs
> $ stat -f -c %T /sys/fs/cgroup
> cgroup2fs
> 
> Is this to be expected?

I think so, I guess (without digging source code) it creates a new mount
namespace, then detaches /sys and mounts a fresh sysfs on /sys.


> 
> I can reproduce it on Debian 13/12 as well as Arch Linux.
> If I enter a network namespace via systemd.service (5) using
> "NetworkNamespacePath=/run/netns/testnetns" I get my expected output:
> "cgroupfs2" instead of "sysfs" (tested on Debian 13).
> 
> First reported here: https://github.com/systemd/systemd/issues/42461

It might not re-mount hence the difference.

Hope this helps.

Regards,
Cong
