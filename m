Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333203;
	b=spzcs7wOQ1SotLnWrfl8fuqdFxqASLOf59BFvA1S+qPr5IpHYAV8Vhizz+GKnrNZ//+W
	 t+01JCSOTtWMMv8Q6HeuhWk+AzWto8rqnXRtPVeV2pa1cwaTCXuwxfwPP37WPQZWlksgr
	 vpF/KAcjHp16Pi1P7oZ41Em9a6hBE9MNvd/glSSN6Kw0YmG/wpd77NohJundBvmz2uGZw
	 W6AjVfeM+fYSKX1yGvRFIFUtF0UtcHqjFfSL15X/tzchS8/2H1SrYa8HBb43qZQzmedP/
	 9nDjqsb770xj0R8ASSzdQI9geE1Fh3f0GBGosMTSyFSdki1oSOqrANKYX/vCgVrpLHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333203;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=vewQ1rC3gNo47kqP/Hx51b9scv8rhIYW439HT73ccWY=;
	b=sEIaS5YIpBaotHFAkBaGUgkV9vzSTB4fXsK7JOu3X2emdhlm2l+t0i/sX0J5aLBMCwlV
	 gmW03gOc6Cnh0kGntLOHc0XBuoCQA0JfufpCUpD5ym9k8yxb7kbCiPUM1WaQTZPVlqqdl
	 gMplPnhTmvBWIzwKYN6Ouq2lacMZmSjJQJ+klWLioAOLRnVwCYO4E+0h6sFBL49XXrWUI
	 +CtDFO2zhyAXQEDp15knpOj3TiRSt9h+0s1sl/WLM7VDghJcOQC4GV9bPM4h5uIehSgcF
	 95TaMMq8tHnH5FcdGkvgNmyofUe2Q3hVjyy1SSRxOvhymp9iEJ3t1mA56H+zweCxkmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUmQjUpo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B75606A331;
	Tue, 10 Nov 2026 17:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PUmQjUpo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D721F008A2;
	Tue, 10 Nov 2026 17:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333202;
	bh=vewQ1rC3gNo47kqP/Hx51b9scv8rhIYW439HT73ccWY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PUmQjUpoKeuGYcTvVsLI8aIfuaSttlsA2XHp/0wiEgY9Ld5vXFlAH8p5lkEA5+VOi
	 UMFR3NMc19579X5GFYdkY2qwikGztNB/TNKkas/T8GnDCdqfiMieQzAyeQI+/j0zOm
	 9bwRsDAkE8cIxyNJejyh+NeSmlhTi+mPOmYbJJdbQbvNV7xlMsrpcg8n2R5qpoF+q4
	 ia4UAI6T+n+/wxf6fhbtSfjnEAN8TX9iKByUh4qjj70BYdvoMJimAmU0aXlPp7mAwB
	 QJlzaR2YToBw6UBNA8x0wNacddFsIuuY8szdqTh1LGmL/q0vzr1JpAy6tHrklI+s//
	 eRco5r4T4R1jw==
Subject: Re: [PATCH net-next 02/10] ice: dpll: serialize changes of the SyncE
 CGU registers
From: netdev-bot+sashiko@kernel.org
To: ivecera@redhat.com
Cc: netdev@vger.kernel.org, vadim.fedorenko@linux.dev,
 arkadiusz.kubalewski@intel.com, jiri@resnulli.us, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, min.li@microchip.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, grzegorz.nitka@intel.com,
 karol.kolacinski@intel.com, saeedm@nvidia.com, tariqt@nvidia.com,
 poros@redhat.com
Date: Tue, 10 Nov 2026 17:53:21 +0000
Message-ID: <179433320107.994134.16333323653199953270@kernel.org>
In-Reply-To: <20261106121005.1327603-3-ivecera@redhat.com>
References: <20261106121005.1327603-3-ivecera@redhat.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit fixes a race that already exists in the tree, but it
  has no Fixes: tag and no stable Cc.

--

ice: dpll: serialize changes of the SyncE CGU registers

This patch adds a cgu_synce_lock mutex to struct ice_adapter, which all
E825C PFs share. It holds that lock around the CGU R10/R11
read-modify-write sequences in ice_dpll_synce_update_e825c(), and around
the ice_tspll_cfg_synce_ethdiv_e825c() call in ice_ptp_link_change().

> ice_ptp_link_change() does not hold dpll_lock, so it can already overwrite
> an update of another PF. RCLK callbacks are serialized by dpll_lock, but
> the DPLL core is going to serialize callbacks per (module, clock_id), and
> each complex has its own DSN and so its own clock_id. With that change, a
> test toggling RCLK pins of both complexes lost an update.

[ ... ]

> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

[Severity: Low]
Should this patch have a Fixes: tag?

The commit message says this race already exists in the tree. Before
this patch, ice_ptp_link_change() on one PF calls
ice_tspll_cfg_synce_ethdiv_e825c(). That function reads ICE_CGU_R10 once
and writes the whole register back twice.

At the same time, on another PF, the path
ice_dpll_rclk_state_on_pin_set()->ice_dpll_synce_update_e825c() does a
read-modify-write of R10 and R11. Each of these paths holds only its own
PF's pf->dplls.lock.

Both paths reach the same CGU. All E825C PFs share one ice_adapter, and
the secondary complex reaches the primary CGU through
ice_sbq_dev_cgu_peer. So a link flap on one port can write back a stale
R10. That undoes a mux or divider change that another PF just made
(S_REF_CLK, ETHCLKO_SEL, CLKO_SEL, *_DIV_M1).

Both racing sequences seem to come from commit ad1df4f2d591 ("ice: dpll:
Support E825-C SyncE and dynamic pin discovery"). A related fix,
bf6dbadb72b9 ("ice: fix PTP timestamping broken by SyncE code on
E825C"), already has a Fixes: tag for that commit.

Without the tag, stable kernels that carry ad1df4f2d591 would probably
not get the fix for this race. Could you add the following tag?

Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")

Another option is to split this patch out of the series and send it to
net.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261106121005.1327603-1-ivecera%40redhat.com
