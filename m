Received: from mta0.migadu.com (out-130.mta0.migadu.com [91.218.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ED92F12DA
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 09:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791625408; cv=none; b=NqQYPtWc1e6v9P1LyP2S7fH7I+0bd9EiA7921vYEH1gtfOhq5Xlt/EW5kTH4qPEc0YziiQKKjfs8ppE5UgNKy8wfWt/wxppuedfrx0K1eP/EZKA8MwH9z23wKT+tn8TcU77VPyJ8UfkN7fpxKJAewzyYoJRHT4We8a4gJF8s4mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791625408; c=relaxed/simple;
	bh=KA7PQQQ0+2GHywNCj78Dee+GHkJauenbmKtXXvKDUys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gtiOUwNeYEVMnMfnNXtNrrvdsr97ULFadSiqiPA4zlEj4ZvR9LCOuYZznqprDi3ojXzSOPlekY7fvqvgb2Tq5JhDq17dpKryY5JUD53U821XPs5cGt91tHJ1b3hnLUcqrpYk3IOVFDqRJwk1BbUnjCDEwAagwXMXDS1eOTQw6Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z06hhJKT; arc=none smtp.client-ip=91.218.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z06hhJKT"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KA7PQQQ0+2GHywNCj78Dee+GHkJauenbmKtXXvKDUys=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791625405; v=1; x=1792230205;
 b=Z06hhJKTY9dGfqOb1uR3W3zfMGfX+9NNtwFbdqu7XANwmQ3iW5SqqA3JKcgKghbd33XetIcl
 82ADv223oKuCQCy6laA4QvUbpqD/jzHpUl4tFHX16L/3bRNAaTxzFB9szHcmmZE+Eiv42hrJGAm
 d/pg8Pi4oQoeIfpKCyrmkZek=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id f0209d5248f65c54;
	Sat, 10 Oct 2026 09:43:24 +0000
X-Mizu-Trace-ID: f0209d5248f65c54
X-Migadu-Flow: FLOW_OUT
Date: Sat, 10 Oct 2026 17:43:18 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Yun Lu <luyun_611@163.com>
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	maheshb@google.com, razor@blackwall.org, netdev@vger.kernel.org
Subject: Re: [PATCH net v3] bonding: 3ad: select a port when the TX array is
 empty
Message-ID: <asoItm3JVXSC5GQ4@fedora>
References: <20261008024031.16224-1-luyun_611@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008024031.16224-1-luyun_611@163.com>

Hi Lu Yun,
On Thu, Oct 08, 2026 at 10:40:31AM +0800, Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> This issue was observed on a machine in real use. During 802.3ad
> bring-up in production, packets were dropped even though the bond's
> carrier was up and LACP had enabled ports for distribution. The
> transmit path only consults usable_slaves and returns no slave when
> the array is NULL or its count is zero.
> 
> LACP port eligibility and the TX array are updated separately. The
> state machine enables ports and updates carrier before scheduling
> slave_arr_work to rebuild and publish the array. The worker requires
> RTNL and retries if rtnl_trylock() fails, so RTNL contention can
> prolong the interval in which eligible ports exist but the cached
> array is empty.
> 
> Add a fallback for 802.3ad when the usable array is empty and carrier
> is up. Walk the RCU-protected slave list and use ports whose
> aggregator is active and which pass bond_slave_can_tx(), without
> taking mode_lock or changing LACP state. In 802.3ad mode the
> per-slave active flag is set only by the mux machine for ports of the
> active aggregator, so these lockless reads identify distributable
> ports with the same criteria bond_update_slave_arr() applies when
> building the array.

`bond_update_slave_arr()` is called from `bond_enslave()`, and it should be
very fast. Could we add a check in `bond_3ad_state_machine_handler()` or
another suitable place to ensure usable slaves exist before entering the
distribution state?

The fallback path seems somewhat complex and costly. Or you can wait for
Jay's feedback.

Thanks
Hangbin
