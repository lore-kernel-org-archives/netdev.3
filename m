Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368463;
	b=V9lcEXbcQKtVA0UThrMkpnTqEwgaUMvPjv+zPnV+YGZgNQr9tG4PrbdhT8x4tDbpgET4
	 VSyIXXzLS7uHRhjjQaF84m5i/Z7zITE8nqAPcgSDOQKZb8lLH+xf6RlJMBGrubnUP1qs8
	 EELpmIhzoAqfBIaqmKniirmgUeqo+XZAuItkyqrQCuIBVWMbW1MEayOjevz6V8jODfxZY
	 qTQYxOV2a3cO3XrlvC1tEootl5da2ivMD1leBnych8DqZ4FOqDCeyKISEynHp4sv2NJ9A
	 +X5pLpfGkB8nHGwKh1VuQo5lpsjZGq+eprEb+AR93hIK17NTfTRMEdRViYEaoT/V39w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=/hIuaSXC/8qKVAwXvaUJ1vLVQZIbwa7mDnRwYchKUok=;
	b=fIctTZpsUagXbPqigATkUCSOggKLwjLLGj4ywjn2sLujnrIzFNZ+/uJtHSZYjOeCn8jz
	 6uBTLN4ioL97s4SaKUhfBqDO3YSPm1PpSkg/Omz/jbrSFQ/qJA+Th3G7BZZOHsMSEB419
	 e/5vNLCIzjhEMNfdvCm/mQfCnwcWv7l9wmXhiqHqp01OVdETbZz/tiHV8KM0OGLFEyep8
	 6IgdWbU4NSJ5QPE1MjmTW9PT/KZatK0ieqKiCTIeUjJsvjo5bp4AC/4qV7uFyHV8EWfc1
	 Nch3pUunOsetj5VMMU3vt61QWVL+YcmFiEys1H4PlSt1JJ6R+tF34ucOzBW0JhdwbGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XWaM6t2o;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0261606A31C
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 13:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0261606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XWaM6t2o
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so5331215e9.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 06:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793368461; x=1793973261; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/hIuaSXC/8qKVAwXvaUJ1vLVQZIbwa7mDnRwYchKUok=;
        b=XWaM6t2olUZqZIxFriVejrYzehUyFljQN5E2CvGc2lNTgSVwJI5hIRBfuMBSzYJW1b
         573FOamRVec1VCMzletpzIxN7E3qGFoLJjVRSWtq0Lg78fbMdn2eGoHbT9tpuw9eKDkb
         hOI6+H/tt2KyetfMO7tK4BJUqLfd2n0gHAw6pZ2biqL5A1JuXRWsNqOeHLx+rByImhzv
         RSfl6WCRNYCVJIXSK6BE78UHY+WWI6kJS+Q6a9blv1tMTv+RJoO0dI7kE9Lcm5F7Frgm
         VeeaM21RYMDPzOqVzVtvdhncwp35WhxDJvWrR+HwCT+mVTFh8BL5Ke8mkmkbnyPnrd9h
         LJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793368461; x=1793973261;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/hIuaSXC/8qKVAwXvaUJ1vLVQZIbwa7mDnRwYchKUok=;
        b=wc3WCAzZi6Fbq8oOL10iNzMzDUI1BK9vsyYIsTlT0J2i5qc3m7rwGJsZ62VzeK6eR8
         /gKl9sqYfGyipIDnEIZ3/ATHVXu/T1/b4jnOvZIFQoUvz58N3jR2F+JRaQyrBU6/tSHQ
         +YD9V0EA/MerA/BQ2MoJRry16nlAlAzIDkAjwD8PQwyuZPnPzWs07t0t+MGJetNrNG7d
         EmlcpUzx8Fwtftek3KEAuQtyQT7i0awCMTpNTthWej6XQkHwvfcNgtheRaY5XcwExng3
         pGDRXdf0SSjuLasJJ0n2U8uhoHEFZSnpFk1DxiruuGqXaH0kfsdkEczgE91g/cb33SkS
         B+mQ==
X-Forwarded-Encrypted: i=1; AKwUvBzVhMay+2grd4KjptP37Yt088z6yPbAGPRaqDC0arRGp9dfbgMB5x3bHWZETbhTwHq1IOAXn1c=@vger.kernel.org
X-Gm-Message-State: AFq9FYIG6Krnp7AUX15vRzOgePOJJ9Waq/cnkGvNgMoZDg5z/cYvJ23O
	LMSBylLk90QgNt2swNHH/gfFITk5KwASRZSzCu5A+jdt0LXm5T0WFZXv
X-Gm-Gg: AYBFou3jF6OsUv2fAT2nB69zwEfEiuzE2ZLYhA2aJfoQsX937xqjLnJr9hf3uVN7GNc
	m2QgyeQ0u/Zzy+b/lUAcYhnj9MmVQ8l9WqvuzSBWIdYKzfELt6GwvHf5fErOfGaqTvAR0k2fHwF
	YzpT1stOfm4G5IqA4jdyG3rhZ+z/8RYM76rt6DqEBGHd4aM1q20rQ574N9Oeljq1/SB7TqcsM0D
	Xe8Id30Qv7Zoj9KAgII1GEHIwV/kgj9k1sVryfuuVrwcn5HQ6Vgr7RhFyx5hoxaMrS5M0sPStNJ
	V+pkR9ozbp4kqlP+pKNc022RALYVWkmFktGqSTixteltpNf9naJ1PkgRC7H/T72AmRhasSi6mHf
	Ecq2vqQq0bAVee2ftRxe2T4iw/pedELbJw1r79yXZrC9cDKsCCb3IPJnTWMoylae8Q1+5MBr8IT
	uzUheUzlaQF/2/ekqnHsffrQ9859bB/4O1PC+yYTp3zh4h6t8DT1ed2EhDZLcJuyuCjj9ldBif6
	del3JgWxtq+G1pjqqPMTYXk7snmry8xd7oF5lxymQ2wi1+wtWT7r8nTl+WlObB0n5RNeHkRhWjl
	trVPVjo7VpwVW1xwES3AvDmesqEMo7U2zeTiSdRF2ja6slwrFWt96S7Oojz7k1q/FfUOLq+q/sD
	MhsO9hG7lSBBPYNw/62Ff8acw0aV/NfyySBr+0BrZvfCRUbsk6VjEOQG061QpDG3xQds=
X-Received: by 2002:a05:600c:608c:b0:4a1:6c0c:ab93 with SMTP id 5b1f17b1804b1-4ac190497bamr46672575e9.28.1793368460933;
        Fri, 30 Oct 2026 06:54:20 -0700 (PDT)
Received: from localhost ([2c0f:3d00:6be:8900:ce5e:9212:ea4b:f30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0950d533sm34613455e9.3.2026.10.30.06.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 06:54:20 -0700 (PDT)
Date: Fri, 30 Oct 2026 16:54:16 +0300
From: Dan Carpenter <error27@gmail.com>
To: Alex Elder <elder@ieee.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>, Frank.Li@oss.nxp.com,
	Frank Li <Frank.Li@nxp.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Matthew Brost <matthew.brost@intel.com>,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alex Elder <elder@kernel.org>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Guan-Yu Lin <guanyulin@google.com>,
	Mathias Nyman <mathias.nyman@linux.intel.com>,
	linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-media@vger.kernel.org,
	linux-staging@lists.linux.dev, netdev@vger.kernel.org,
	imx@lists.linux.dev, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/1] PM: runtime: change stub pm_runtime_get_if_active()
 return 1 when !CONFIG_PM
Message-ID: <auShiOI6Hmla6XxR@stanley.mountain>
References: <20261029163044.3062958-1-Frank.Li@oss.nxp.com>
 <auRb_r8ZSSU-eHZA@kekkonen.localdomain>
 <9207a52e-2d42-4e10-b777-2988e84d7dbe@ieee.org>
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
In-Reply-To: <9207a52e-2d42-4e10-b777-2988e84d7dbe@ieee.org>

On Fri, Oct 30, 2026 at 08:46:07AM -0500, Alex Elder wrote:
> On 10/30/26 3:57 AM, Sakari Ailus wrote:
> > Hi Frank,
> > 
> > Thanks for the patch.
> > 
> > On Thu, Oct 29, 2026 at 12:30:37PM -0400, Frank.Li@oss.nxp.com wrote:
> > > From: Frank Li <Frank.Li@nxp.com>
> > > 
> > > When CONFIG_PM is not enabled, all devices runtime PM state should be
> > > treated as active.
> > > 
> > > __pm_runtime_resume() returns 1 (called by pm_runtime_get()).
> > > pm_runtime_get_if_active() is the try-and-get version of pm_runtime_get().
> > > stub pm_runtime_active() also returns true. So pm_runtime_get_if_active()
> > > should return the same value as the stub pm_runtime_get(), which is 1.
> > 
> > Shouldn't the same change be done to pm_runtime_get_if_in_use()? It's
> > otherwise the same, except that it requires also the use count to be
> > non-zero.
> I think "yes."
> 
> I think the logic for !CONFIG_PM should basically pretend runtime
> PM is enabled for all devices, and they're all ACTIVE and effectively
> in use.
> 
> That implies:
> - disable_depth == 0, so usage accounting would (if enabled) be done
> - runtime_status == RPM_ACTIVE (power is on, no delay)
> - usage_count > 0
> - runtime_error == 0
> - Maybe ignore_children is false?
> 
> This might not be complete (and could be wrong!).
> 

We could add this kind of information as a comment somewhere?

regards,
dan carpenter

