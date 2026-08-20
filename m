Received: from mta0.migadu.com (out-129.mta0.migadu.com [91.218.175.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D954B3B19B9
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787216965; cv=none; b=kazyZgTGA/pGSuSRhZrcKv1fwyzNiF1h0wS8RcDTPieEAcHePTcx+hVAo9EWkxsIO7iKrnOwGjS+ldTs90lbuZgdFycQbDFpvjl7RHaBqTzEMwk7ZPMEhhC866KXak//SsKkwjqd6EsdxcRks4/kSF7h2FajQTjU69q1HYPQ3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787216965; c=relaxed/simple;
	bh=Cupuo0Pa3NQdExMqql7ynHhfJ3wuMywX5oHkv98MmAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ua/0WDU9gatN470U/5pbel9plJbU4629pVUxB3KsNWX9XOATvXXoFDD83PBNh1wGjRK7653mTKfITGgUQLfRHZGYnZiMQKM9lJ31l56pulD/Il5bR9e3usJIjxy6N2TjKEcwSshQrRKiX4633PAkzauuAkLSuwvNVtFvHBsv5JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Rkchv7hG; arc=none smtp.client-ip=91.218.175.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Rkchv7hG"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Cupuo0Pa3NQdExMqql7ynHhfJ3wuMywX5oHkv98MmAk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787216961; v=1; x=1787821761;
 b=Rkchv7hGD1XOVqDtbj41Bz3QndRHNSkZG3yUmyERTjaztEdWlrwQOWDaOWGDB2gGmHGbjA79
 UWuUJ5Fw6LRvxUywq4nzBMpZN9c8tXkne5EeOLYU9QfIpSKY1qW8dXIsxnOu5ypTrJ2fWs/XV6H
 5aX9VNlH10F4tk2wxM80Oqe8=
X-Envelope-To: netdev@vger.kernel.org
Received: from fedora (203.175.12.241)
	by smtp.migadu.com with ESMTPS id 9f8cf05874ae049c;
	Thu, 20 Aug 2026 09:09:11 +0000
X-Mizu-Trace-ID: 9f8cf05874ae049c
X-Migadu-Flow: FLOW_OUT
Date: Thu, 20 Aug 2026 17:09:04 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH 0/2] bonding: 3ad: fix 2 RCU issues in ad_mux_machine()
Message-ID: <aobEMA3NRBt7YVMt@fedora>
References: <20260817-bond_rcu-v1-0-acf067cf45fe@kylinos.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-bond_rcu-v1-0-acf067cf45fe@kylinos.cn>

Hi,

On Mon, Aug 17, 2026 at 04:32:35PM +0800, Hangbin Liu wrote:
> This series addresses a NULL pointer dereference in ad_mux_machine()
> when ad_port_selection_logic() detaches a port from its aggregator
> but does not assign a replacement.
> 
> Patch 1 adds an early null aggregator check in ad_mux_machine() to
> prevent the oops. Patch 2 is a minor RCU fix that uses RCU_INIT_POINTER()
> when initializing port->aggregator to NULL.

Please ignore this patch set. I just got back to upstream after a few months'
leave and didn't catch up with the new policy before sending this series.

The first patch is only theoretical and has no reproducer. The second patch
is a NOP, as Eric said. So let's drop this patch set.

Thanks
Hangbin
