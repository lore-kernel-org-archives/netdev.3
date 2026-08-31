Received: from mta0.migadu.com (out-122.mta0.migadu.com [91.218.175.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE8921CC71
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 01:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788139438; cv=none; b=PsBPM8cMHaSTzE0Z+zRvqKkoxgr541i9okc+tpKxi7Nhw/QB2wFOMioNqKJApVYLE5qGeJUo9e6GUrIeEQhsWo0SLUwOVw33veJmxcgXgDok2mZJS1w7K1O6i6vUL5tnqCu38mlwg80O6u18ETZ2XxEzPgqmkShmjU+vV+1rHyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788139438; c=relaxed/simple;
	bh=cTeEuccT2PKVpzCvAuCxC2zeJqk0NMGvrpNIIWSN0oY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=acb3fv1Td8kmSjt56+0A5M9RVbXaHlfZPQZKk1sElTaI+XFI4YveXpUqQ1d/ZmrnAEaWom6UyeLFN7621v8uWkW/yuC49aQjgJ3Ai2eDzWVFLV+dvqq/98CuzpCO8zV/VsyVluYqFn9MsB9irlCB0qq0AM3MZMVvxGHDEZT+xiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HiV4aecM; arc=none smtp.client-ip=91.218.175.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HiV4aecM"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cTeEuccT2PKVpzCvAuCxC2zeJqk0NMGvrpNIIWSN0oY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788139433; v=1; x=1788744233;
 b=HiV4aecM6qdnxoPXzmlQRBPTkbnQQsWJqXz5ERUESAwCEXp+TShp/c5XJD5X3bbwV6pcMqbe
 hxpC0my/juuXjy5LyRNElzVV7EKfi1WQzMRMEpgVyZBJUJEA/RbLPyL2OVNLSqaTfjVcOU6XlOF
 9sfjtD/AUTUI0nuH3zZsDP3I=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f1b9064f72c984e7;
	Mon, 31 Aug 2026 01:23:43 +0000
X-Mizu-Trace-ID: f1b9064f72c984e7
X-Migadu-Flow: FLOW_OUT
Date: Mon, 31 Aug 2026 09:23:31 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH net v5 2/2] bonding: fix u32 overflow in compute_gap()
Message-ID: <apTXkxseTr_1to2u@fedora>
References: <20260825-bond_overflow-v5-0-7a800de133f1@kylinos.cn>
 <20260825-bond_overflow-v5-2-7a800de133f1@kylinos.cn>
 <20260827192048.39ea95e6@pumpkin>
 <9e71daf9-aad4-4c8b-9fc4-7429f62130c7@blackwall.org>
 <20260827215611.1cb9f252@pumpkin>
 <31228099-41a8-4976-acc3-9b320a5012ea@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31228099-41a8-4976-acc3-9b320a5012ea@blackwall.org>

On Fri, Aug 28, 2026 at 12:19:47PM +0300, Nikolay Aleksandrov wrote:
> > > How is that relevant to these patches?
> > > And how does that help at all if today that is done at about 10 second interval?
> > 
> > The 10 seconds is almost certainly completely arbitrary.
> > It is relevant because the 64bit divide is significantly expensive on 32bit.
> > 
> > David
> > 
> 
> Yeah, that is clear. But currently that recalculation is done once every 10
> seconds, such optimizations will be noise. Regardless of that, these changes
> are unrelated to the problem he is fixing with the set.

+1.

Thanks
Hangbin
