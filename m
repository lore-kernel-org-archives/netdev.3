Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77FC47A0C7
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 17:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775064816; cv=none; b=U2h0rjM5T+faO6I8HH+OugFfVqhHGCyHFSMrGpNTJw7V1Pyy/bMEQQdYhKiyVmx0RdRHX2/dZxJdboNoRFJZzMrocWvLpmSPY99Js2yGt9PFsz/SqmtOedPUYHpcmMYJgABIJK60PcfC8mpDFjGnNE/fRKYYXS6tsXCj7eQ7vJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775064816; c=relaxed/simple;
	bh=GALUpL9FcmSNoTtHE6SpePyLmLDTRd/mTbP3SWjUuZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UBfXcZ0UdXVi5Aj+T+AYZc6t0+wHK1jZW4iZcQ1hZGl9f37iI2Na3/MV5P0CIHjGlh0s8MIiDsFFTUXtPUxBG+CVH9z+C081qdqJdq0feSMTaOSofKHgyoIcG14T0Iz9aip9mGogPBWtBS0iLaqZ+oJljsvi7nGGlMr+LFOeYMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jN3S4vo9; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jN3S4vo9"
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6500040ef83so2254d50.2
        for <netdev@vger.kernel.org>; Wed, 01 Apr 2026 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775064814; x=1775669614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aLnfQJSw9REm8a9+311bKseMryW3/suAyHmSGj3g0SU=;
        b=jN3S4vo9GyI2XB8Fn/2MYWFXOCDgzoUTeZjXWDVdiUqT5EiNDMAgL0TppgHK4Pb1GQ
         w7gwMrL2qoaPoVHje+nFVixsYdAxvZXYuqrRGcUVcKkAE403IqYC0c0bwhvmx7Jb5c6H
         YV4ORyoMHUwNIonuUnYgtwDyNvoifgjRn6yGopphXa/sb+UbXF3yPRM1Hd74sfhYuhy8
         32v0wkH5kbXdzL5uN8r7uIKXRjcpWj6l5cGBxso0XI/jndUsqqlHz3KQMhhhd7XK+vQX
         +WdaTHrO6T8RLsTVNNsnn1FxwrQQsmEJdmRKl8Bg/kg0k/JYbPkPr1x99xOhfBRI79jP
         jNmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775064814; x=1775669614;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLnfQJSw9REm8a9+311bKseMryW3/suAyHmSGj3g0SU=;
        b=CiLbNK9i8EA0VexOrTGMVInRTamNDw2S6eotfQgySu6UJN/yQxu19oNqdseI2fC5tB
         8nbedE3gXf/Ae/VuApoep8kXZLiayjdAAz3Qtj+B3zjl55NPpXcpBE/C0zoQTsqxP8Uj
         2u1JJ+KOrqWHKvsadEsQ02wQ/WHFFFK411R5pUjWIL//02Z+NxH5ZXNGyBVEjA91RCr1
         vf1uoiFso8/jt9/OJ7JOYOpavquprtW2r9aFpSvU7ZXMOYG8XAAk7QOv8wCAENrePlMi
         DZQkoBFlHaWQuxcm1nQ8Km3sqBgkjiAHQqu/STa5lsKDgCgBaVd0IrRTf4pgBpH6DsRY
         ezCw==
X-Gm-Message-State: AOJu0Yznm6MjhCZAyIiinokyKu83TZkPK/YLJ4HtsvaxGNh+NCY+gG15
	jvQCNxIOw9umIzz2Hy+utMpQdbgUDZAK0iLJM+3LUKsJB4/yXKw+okru
X-Gm-Gg: ATEYQzyMKJUL74e7yTKWnyABdBeQTDDo7EJLHjWKbPe0Kc2m/bhpRlugZL9f2EM/o3M
	jH52DY80mnYIo/teBr6//vX0k1fzn5aqpPZA2/piMpSbX1ETL5TToDqFAOW1sKdUTXlkgHUHtW9
	uxCg0SY4w3kMGsV6qNlwal0wvLfjtLXyK/rWp/k4l8gCAVJic5ZXWtmh61MFtapwyBMwqd7rVLH
	IsumMN8y4iJ8h2bjZMV2vilUtLUhCj48zSQLnjICIxMgyB3K2LSvnT08/ihb7/aJqONfVsDhuEj
	4SBAH/Xv4nyislkTUox/gZOttqQwuci8vkR1BLkKJdHotA76On2cBWQUBkl0VC2FnSoVnDUV29C
	0iffmQOsWST/DYbyMLbeKPXIj5u15M6RcUw/EwzUoDGIiWsuOFsj6tyQ+ZkNYURkSW31XQHeNfn
	m2C8KyN2QfQgvAXjm0shYl1XYuvEe9PW4d
X-Received: by 2002:a05:690e:1c20:b0:650:3aae:e2e6 with SMTP id 956f58d0204a3-6503aaee65fmr764874d50.20.1775064813767;
        Wed, 01 Apr 2026 10:33:33 -0700 (PDT)
Received: from syzkaller ([2a03:2880:25ff:5c::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm214698d50.3.2026.04.01.10.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 10:33:32 -0700 (PDT)
Date: Wed, 1 Apr 2026 10:33:27 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	virtualization@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>, Jin Liu <jinl@redhat.com>
Subject: Re: [PATCH net] vsock: initialize child_ns_mode_locked in
 vsock_net_init()
Message-ID: <ac1W53WyCMYyOv4f@syzkaller>
References: <20260401092153.28462-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401092153.28462-1-sgarzare@redhat.com>

On Wed, Apr 01, 2026 at 11:21:53AM +0200, Stefano Garzarella wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> The `child_ns_mode_locked` field lives in `struct net`, which persists
> across vsock module reloads. When the module is unloaded and reloaded,
> `vsock_net_init()` resets `mode` and `child_ns_mode` back to their
> default values, but does not reset `child_ns_mode_locked`.
> 
> The stale lock from the previous module load causes subsequent writes
> to `child_ns_mode` to silently fail: `vsock_net_set_child_mode()` sees
> the old lock, skips updating the actual value, and returns success
> when the requested mode matches the stale lock. The sysctl handler
> reports no error, but `child_ns_mode` remains unchanged.
> 
> Steps to reproduce:
>     $ modprobe vsock
>     $ echo local > /proc/sys/net/vsock/child_ns_mode
>     $ cat /proc/sys/net/vsock/child_ns_mode
>     local
>     $ modprobe -r vsock
>     $ modprobe vsock
>     $ echo local > /proc/sys/net/vsock/child_ns_mode
>     $ cat /proc/sys/net/vsock/child_ns_mode
>     global    <--- expected "local"
> 
> Fix this by initializing `child_ns_mode_locked` to 0 (unlocked) in
> `vsock_net_init()`, so the write-once mechanism works correctly after
> module reload.
> 
> Fixes: 102eab95f025 ("vsock: lock down child_ns_mode as write-once")
> Cc: bobbyeshleman@meta.com
> Reported-by: Jin Liu <jinl@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
>  net/vmw_vsock/af_vsock.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index 2f7d94d682cb..d912ed2f012a 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
> @@ -2928,6 +2928,7 @@ static void vsock_net_init(struct net *net)
>  		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
>  
>  	net->vsock.child_ns_mode = net->vsock.mode;
> +	net->vsock.child_ns_mode_locked = 0;
>  }
>  
>  static __net_init int vsock_sysctl_init_net(struct net *net)
> -- 
> 2.53.0
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
