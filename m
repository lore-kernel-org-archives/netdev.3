Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388CB53CA7B;
	Tue,  8 Sep 2026 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871124; cv=none; b=nlLRQXSyFjoNJBzYEAjKiWZ4RQNEo1UM4ZVRht4toYgPyattrgLbyOss0gm5A5cgRH7G/a0XzISDHSzxvxgPz62hZu/vX9s06/MUI+Z+ACPTe9Ji+170DS2aUbHxIrDsx9laOvfBhLEF9ZFRNa5jfmezirbDDwJZHV6reprR9uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871124; c=relaxed/simple;
	bh=mrRYM5tOClw+BiqxeDKSNnUxEAefORGFZfIqBMRiefc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1MWJJ/uixw5m/xLog3Khw0GL7oOoCEJ/PnLFSckFW5qj1hsjPLlXoMt/LU11+k6mR0+2k7oz2eYOcNgGQG0N3XnlHKQvivPjNJUX2uAb/IUQJ7crWx2kYktfuOM1qyME0KuJp4VpJ6lTqiQzSTomuTqriD30nKS0PBknUCOyxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=m3awaFMc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="m3awaFMc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Dg0hFM3g5sppDFjiV0SP+8oKIEFHlXYJz1ar8PQLnok=; b=m3awaFMcJ3syIAGWU45EEyMPZH
	KqwOZxN4sRgK1TEDUjaOyBWGdQk5QZ8MC/QkVtHGPWStwUnqm4o1ZeBoTYD8dho40f7gLIC4g07Oo
	vgk4hjsoEUWDWMqFV1D0MdZD/1orCdvcSaKlWH7chXMsHNuhvwQc4D7rInOOc8/zrWkM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x3v5m-003tE8-EX; Tue, 08 Sep 2026 14:38:26 +0200
Date: Tue, 8 Sep 2026 14:38:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	Frank Wunderlich <frank.wunderlich@linux.dev>,
	John Crispin <john@phrozen.org>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, driver-core@lists.linux.dev
Subject: Re: [PATCH net-next v13 5/6] net: dsa: mxl862xx: recover switch
 stuck in MCUboot rescue mode
Message-ID: <efdade1e-3d15-4e0f-8a80-8465e963f6d3@lunn.ch>
References: <cover.1788783126.git.daniel@makrotopia.org>
 <f373ce50bf741c50ff5249a538088a9451aa5730.1788783126.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f373ce50bf741c50ff5249a538088a9451aa5730.1788783126.git.daniel@makrotopia.org>

On Mon, Sep 07, 2026 at 07:38:40PM +0100, Daniel Golle wrote:
> A broken or interrupted firmware image, or the sticky rescue bit, keeps
> the switch in its MCUboot bootloader, which exposes only the clause-22
> SMDIO download interface. The clause-45 MMD API never comes up, so probe
> would fail with -ETIMEDOUT and the only way back would be the switch's
> UART console, or a power cycle or out-of-band reset (not currently
> implemented).
> 
> Probe for the loader over SB PDI at setup, before any clause-45 access,
> since the C45 API floods the log with CRC errors when no firmware
> answers. A scratch write to two mailbox registers first establishes
> that a switch is there at all. It reaches a running firmware as well,
> but lands in registers that firmware does not read, so it is inert
> there. The status register the loader publishes then tells the cases
> apart without touching C45: a running firmware, which answers with its
> own non-zero status word (0x0003 on the firmware tested), so probe
> continues normally; a loader idle in its console loop, confirmed live
> by a register-read challenge; a loader wedged mid-download, the one
> case that publishes zero; the flashless download loop, which this
> driver cannot drive; and a switch whose scratch write does not latch --
> absent, unpowered, misdescribed in the device tree (wrong address or
> bus, or a reset GPIO with inverted polarity), or with its SB PDI window
> somewhere other than the OTP reset offsets assumed here. The first
> three enter rescue mode or normal operation, the last two fail probe
> cleanly with -EOPNOTSUPP and -ENODEV instead of a CRC-error storm.
> 
> A loader that publishes the ready magic but never services the
> register-read challenge fails probe too, with -ENXIO. The challenge is
> what tells the loader apart from a firmware whose status word happens
> to read the same value, and offering to flash a healthy firmware would
> be worse than refusing to bind, so a mailbox that does not answer is
> treated as unusable rather than as a flash target. Every loader tested
> services it.
> 
> In rescue mode the switch registers without user interfaces so devlink
> stays available: user ports fail port_setup with -ENODEV (the DSA core
> re-registers them as unused) while shared and CPU ports succeed, and the
> CPU port works on its fixed link with mac_select_pcs returning no PCS.
> Firmware API commands fail fast with -ENODEV and the port and STP
> callbacks become no-ops.
> 
> An interrupted download can leave the loader wedged mid-payload. A
> background work item off the devlink flash path drains it back to a
> clean ready state by feeding the outstanding byte count one byte at a
> time, which takes tens of minutes for a large image and is logged as it
> progresses; until then devlink dev info reports no version and devlink
> dev flash returns -EBUSY, and -EIO once a drain has failed for good.
> Reaching the end of the count is all the drain does: the loader then
> verifies the corrupt image and returns to its console loop on its own,
> so the drain reprobes and lets the probe-time detection re-classify the
> switch -- a valid image that a last-moment interruption left bootable
> comes up as running firmware, with no second-guessing in the drain path.
> 
> The re-probe the drain schedules is the same device_schedule_reprobe()
> hand-off the flash path uses: the core skips it if the device is
> unbound or shut down before it fires, so a drain finishing after the
> driver is gone does nothing. Should scheduling it fail, recovery is
> marked failed, since the loader would otherwise sit at a clean ready
> state that nothing reclassifies while devlink keeps promising that a
> retry will work.
> 
> The CHIP ID registers need a running firmware, so no asic.id/asic.rev is
> reported in rescue mode. Once the loader is ready, devlink dev info
> reports the null firmware version "0.0.0" as both running and stored:
> 
>   $ devlink dev info mdio_bus/mdio-bus:10
>   mdio_bus/mdio-bus:10:
>     driver mxl862xx
>     versions:
>         running:
>           fw 0.0.0
>         stored:
>           fw 0.0.0
> 
> An operational switch never reports 0.0.0 (a released firmware's major
> is non-zero), so version-comparing tools like fwupd offer every release
> as an upgrade, recovering the switch through the regular flash flow,
> matched on the driver name. The flash skips the FW_UPDATE command since
> MCUboot is already waiting. A successful flash reboots the switch into
> the new firmware and the reprobe then brings the driver up against it
> normally; after a failed one the switch is still in MCUboot, rescue mode
> is detected again, and the user can retry.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
