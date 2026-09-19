Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C9A3AAF65;
	Sat, 19 Sep 2026 01:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780039; cv=none; b=A+rhS95dyOGQS4ZqiaYJ5Ir6RPn+DpcWV9uG36E2i8NO/daM6O2B3Au+/aMen+LOwko9PZAwcdv3hAcvXt3uQKeluWw5zZ2I7RcDU6XSXi05DEOqnTJDp5fSbm16StmpwJAFa3a0YFcqKReJ/ofF6Khd2BBiplHLlB6yPHSet6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780039; c=relaxed/simple;
	bh=5oNs9PI8NLa0Dd8AKOjBrnydgdrAbQsvVrK1J57eKP4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qsxtk0Gc1UWZ3HbpKuHkfzskQtefsvXEkx8Ir9CbLcnAs9o2GSgbE02dXJIdJn2cfu7rD2jxlDEZe3OlN/Rt2WT+Be8FAbUP0oawOq/EiwDIAS2QOb5TRHgxCWxZn7HwENgscQ7QBHCnvdrcOAJaCC+Kq6GSSJocjrm8OWddm7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DqY6X/wg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DqY6X/wg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18E21F00898;
	Sat, 19 Sep 2026 01:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780031;
	bh=54z5SHlzrtBebb/X3YpRpc4JfK56SguCLPAt7r3wZ0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DqY6X/wgf0ZvI/qmkkkq9008FZOOCDULO9vS7BK1OVjEmpBq1O6JjpH4ziCEq0bNu
	 Ppik+IosP5jIqP98FvLJBLVFTGMRFlzLGb+YuVUdIU+NHUQk2obZheMTB8sTgB9XQc
	 HvZOTereYSkhF/hRriYf00wDHLTlXYaSTSBf/7bMRVxuaD+z4Z0GR7+YLQM8LePxZK
	 g6Br32OKZ/YvToD9FbX431FwVqze0AkzkMfseiaRoqSqR98GuPJRnlrsCltIgZVYk6
	 qRkVygyRYk4f9H/wFXZRAmHZaWL1auJsOJIUgK8hZ0gM8yF0gRfe1dygrfWn07r/y2
	 S82iN4am91sNg==
Date: Fri, 18 Sep 2026 18:07:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH net-next v16 0/6] net: dsa: mxl862xx: devlink flash and
 rescue
Message-ID: <20260918180709.2fe12c2c@kernel.org>
In-Reply-To: <cover.1789477568.git.daniel@makrotopia.org>
References: <cover.1789477568.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 14:09:03 +0100 Daniel Golle wrote:
> This series adds "devlink dev flash" and "devlink dev info" support to
> the MaxLinear MxL862xx DSA driver, and makes a switch stuck in its
> MCUboot loader recoverable through the same path.
> 
> The switch is flashed over the loader's clause-22 SMDIO download
> interface after the firmware API has rebooted it into MCUboot, and the
> driver reinitialises through a deferred detach and re-probe once the
> new image runs. A switch found in MCUboot at probe registers in a
> reduced rescue mode with firmware version 0.0.0, so the same flash flow
> recovers it; an interrupted download is drained in the background
> first. The deferred re-probe comes from a new driver-core helper,
> device_schedule_reprobe(), since a driver-owned work item cannot
> survive a racing rmmod, nor give up its detach once the core has
> blocked probing for a shutdown. fwupd's devlink plugin carries the
> matching quirks [17].
> 
> Patch 3 is a driver-core change and patch 4 does not link without it,
> so the series needs a driver-core ack before net-next can take it.
> 
> Tested on an MxL86252C switch of the BananaPi R4 Pro 8X: an upgrade
> through fwupd; a reboot issued while a flash was running, which waits
> for the transfer to finish; a host crash mid-transfer, whose wedged
> download the background drain recovered; and a power cut mid-transfer,
> after which the loader came up ready and fwupd flashed the switch from
> 0.0.0 back to a released firmware.

Having the "rescue mode" which only allows flashing a better / working
FW is fairly common these days. Did you consider driving the operation
more from user space. Let the user devlink reload into flashing mode,
and devlink reload back into normal operation mode?
