Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A546C271464;
	Wed, 21 Jan 2026 03:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768967445; cv=none; b=cJGPO17HBpIxHEkx4CSNuCyMBNO5BqbOtDADx7NyaCX3whivZAxmKkcoaH/l39pCiagqm59sOWDCDOmUWpcMk5Lmq1aZGrPd0JIplVKO/SShMK7b94d9vB6hV+sIiHmEhE5lq7+G36cJf5fG/1HU3yO+Nadh4N4m4E45Mhsv/ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768967445; c=relaxed/simple;
	bh=ONIfixNSBed8y1//bhXBif3hMWFst2m9Ve4WEzHasQI=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=WyM7RcddAQcbPs/4TAxG3iaWisE/r3dzTTXeGvQEn3bry0miINQMXU1mXnIlxEBh3bho+fxhbjacmXB8UXKroYZDjA7gwsH01YVgFY8RWfb6EibqQCgXOBwin8hngw/hZUehmxVLcPlV6aY0QLp6CIz2xYY5hXRG6fyNbVr3PrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UocT9g05; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UocT9g05"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436E1C116D0;
	Wed, 21 Jan 2026 03:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768967445;
	bh=ONIfixNSBed8y1//bhXBif3hMWFst2m9Ve4WEzHasQI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=UocT9g05QmC669Vqn4jP22CvNPvxULzb8QwHvuVBqtICWTTwbZCZy6EM9fGLaj107
	 Vrv7gB3Yek29Wh4LLZ0yvB/XWvehUE3cuHl4MVDXtyW8pYXyr6Xvf9Ja1mCU58+fdt
	 kCjwteBJqieD6mrFZiItnxnaDNEMnTHYcdqLfOsxJ9up9nm1kfI3GiffprHS73U5SM
	 AbhsqLB1PTJgBpUCNbkpsh9ngDiOTdy+n5cQM0N/2+9EaSofgEUStbObut4BppjxDQ
	 3B0KxguUWCxbgoFH/pjMSez1KS5uhtzhzYq/+zINa+taivVOkpyVgHxIoxckIoi2v8
	 fNZJYdBv7jg3g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260116192725.972966-2-suraj.gupta2@amd.com>
References: <20260116192725.972966-1-suraj.gupta2@amd.com> <20260116192725.972966-2-suraj.gupta2@amd.com>
Subject: Re: [PATCH V3 1/2] clk: Add devm_clk_bulk_get_optional_enable() helper
From: Stephen Boyd <sboyd@kernel.org>
Cc: sean.anderson@linux.dev, linux@armlinux.org.uk, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bmasney@redhat.com
To: Suraj Gupta <suraj.gupta2@amd.com>, andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, michal.simek@amd.com, mturquette@baylibre.com, pabeni@redhat.com, radhey.shyam.pandey@amd.com
Date: Tue, 20 Jan 2026 20:50:43 -0700
Message-ID: <176896744341.4027.4548470924295153506@lazor>
User-Agent: alot/0.11

Quoting Suraj Gupta (2026-01-16 12:27:23)
> Add a new managed clock framework helper function that combines getting
> optional bulk clocks and enabling them in a single operation.
>=20
> The devm_clk_bulk_get_optional_enable() function simplifies the common
> pattern where drivers need to get optional bulk clocks, prepare and enable
> them, and have them automatically disabled/unprepared and freed when the
> device is unbound.
>=20
> This new API follows the established pattern of
> devm_clk_bulk_get_all_enabled() and reduces boilerplate code in drivers
> that manage multiple optional clocks.
>=20
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
