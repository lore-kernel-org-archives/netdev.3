Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079BB38F251;
	Tue, 28 Apr 2026 15:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389197; cv=none; b=larOQGcic7701EpiNHM4JkCIBcAFY2/5qc9cVUU6P+C6WXExMJThoPtGE62pt1vpeNOfb8z1b3j4iQrc9PbsFtBHclrTDhG8vkPUc/dHLpXGbJu3B9V3Vo2F7BhxhJfjzv47PCW3qvMJjqvKrhx2k0qcj4YXw2O70NIv7zdvbzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389197; c=relaxed/simple;
	bh=6fFHNJC7+5kKW56ZhJcKHcNKRLt3YELgG+gR/jUoZxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hz/I25mZOM2pobdT2YyFiuEFva72HBcvKw8Ey9RMyKspDs8AYj32p5xJ9aqXJRi9Q37UyOKtIMHDmNZ5Y86NjPziLdX0Gai6nklZzXGxMhaSSgvnP9pT4O0zCQQ2ZkSr+6gTlnn1nOmJJ2jNEjJNxRuN2w71vEzFc2AyhxCR3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwScEoKi; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwScEoKi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777389196; x=1808925196;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6fFHNJC7+5kKW56ZhJcKHcNKRLt3YELgG+gR/jUoZxQ=;
  b=lwScEoKiFvfAWz55lUcwFi4bp9w371mp0t5LRMbUDfU0O9eOOk6ocsEx
   1GmVlc6BmJxS3BD4KNCwML4u0rrAIOoHaFWHmI3P3KV9aCFOz9zT7sBS3
   xrbh+d5lIjWeM+CS1Wt3UysrTUAMJRbImTx5gSJ1DpawXGfdZEYazvqCy
   wqTV717+11LhgqC8OZPGpoG4NsMViByRDSaKPS6ktuvwphdb7vI7pmehm
   eR1ZQtfOE8IIEo6msJSxZoT/4zK03DkXmYSv5aow3OZe2QGCinwvpPO4O
   ZIuM9C+7k0S3fNHq+7ZBw2pvSoAJbukPuY+hXgLplUTX7u0ryrVQ+n7/a
   w==;
X-CSE-ConnectionGUID: RYv6iywuQgGWB+eti7FrTw==
X-CSE-MsgGUID: +5GL9bgDS26lfqZWW4CQ3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="78216045"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="78216045"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 08:13:16 -0700
X-CSE-ConnectionGUID: oeIz82csT92U4pNTOoVXmQ==
X-CSE-MsgGUID: s21mIPu1RreP3ubRGO3BYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="234280367"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 28 Apr 2026 08:13:13 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id B998C95; Tue, 28 Apr 2026 17:13:11 +0200 (CEST)
Date: Tue, 28 Apr 2026 17:13:11 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-usb@vger.kernel.org, Yehezkel Bernat <YehezkelShB@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	Andreas Noever <andreas.noever@gmail.com>,
	Alan Borzeszkowski <alan.borzeszkowski@linux.intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH 9/9] thunderbolt: Add support for USB4STREAM
Message-ID: <20260428151311.GU557136@black.igk.intel.com>
References: <20260428072209.3084930-1-mika.westerberg@linux.intel.com>
 <20260428072209.3084930-10-mika.westerberg@linux.intel.com>
 <ef5411f4-0e4c-4ac1-8ae0-0d557fc0ebd2@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ef5411f4-0e4c-4ac1-8ae0-0d557fc0ebd2@lunn.ch>

On Tue, Apr 28, 2026 at 05:08:55PM +0200, Andrew Lunn wrote:
> On Tue, Apr 28, 2026 at 09:22:09AM +0200, Mika Westerberg wrote:
> > Introduce USB4STREAM protocol and Linux implementation. This allows two
> > (or more) hosts to transfer data directly over Thunderbolt/USB4 cable
> > through a character device without need to go through the network stack.
> 
> Is this mutually exclusive to networking, on a device?

No - they can co-exist.
