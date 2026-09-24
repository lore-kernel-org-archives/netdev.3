Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F272C6FC5
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215726; cv=none; b=D4ajbI7ueMJdO0011S1b+y0zKhyR6A2lCJVEBHs9GuwjIslM5tc/2nT3ekiCSYFKjXICoTP7uORVkI07H7rjDTdFt6bULS17BiGek+rYsQVnC7UuPtZkG6vxbiT6NPzp6bR4c+X7TyyDGHTr3NKxyNgodv/ybFHigbiXZ+nhlbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215726; c=relaxed/simple;
	bh=5d20WDnLgsvtaIULBmKsmqlBi/8EtUWD0YWH6Pn5UhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WhtCpqmSx1VC9vFUIrZ+R+JtcUCwNJ7D84eEH68uhq+YhVs8PrzpX9z3u09liYFkfL09N2N/LGaN+Yoi+7/kBCFIEY4zibzt1cZS0G7XvbXnNlWrxHvU8XPHrS0VYZk7B7bWe4UToqrM7JX5KHwYPxPKR9Wtcx2+Tobx70Urxbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XONWRTXA; arc=none smtp.client-ip=91.218.175.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XONWRTXA"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5d20WDnLgsvtaIULBmKsmqlBi/8EtUWD0YWH6Pn5UhI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790215721; v=1; x=1790820521;
 b=XONWRTXAMkxNpZ/p8ohvfOwXuIcMr+q8OrCmbjQAiZB10yuRex8L5vKtzrmDa4C7HvMXc7yD
 HEcAItBrOfe7g3Y7IFVaLmc0ygKOHGa4JhOUvhZRjtV3tTIw/nap1xepGCqDIRmiscNVoM6e4M6
 aQXMFJoEkuN9Lw+XYnfxmyd8=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 19901d729ad6435e;
	Thu, 24 Sep 2026 02:08:41 +0000
X-Mizu-Trace-ID: 19901d729ad6435e
X-Migadu-Flow: FLOW_OUT
Date: Thu, 24 Sep 2026 10:08:32 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Neelima Muralidharan <neelima@ti.com>,
	Paolo Abeni <pabeni@redhat.com>, Praneeth Bajjuri <praneeth@ti.com>,
	Pratheesh Gangadhar TK <pratheesh@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v6 8/8] selftests: hsr: Add test for the inline
 PTP header on HSR
Message-ID: <arSGILQLfqYGugpy@fedora>
References: <20260923-hsr_ptp-v6-0-6ea07b3fb8a8@linutronix.de>
 <20260923-hsr_ptp-v6-8-6ea07b3fb8a8@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-hsr_ptp-v6-8-6ea07b3fb8a8@linutronix.de>

Hi Sebastian,

On Wed, Sep 23, 2026 at 02:14:09PM +0200, Sebastian Andrzej Siewior wrote:
> This test verifies the inline header which is used by HSR stack with the
> ether type ETH_P_1588.
> The HSR stack needs to recognize this header, strip it and send the
> requested packet only on the requested port.
> 
> This test needs a HSR device and the two slave devices passed. It will
> will send a sample PTP packet with this inline header, requesting one of
> the ports combining with and without the HSR header. A total of four
> packets is sent.
> The test checks both ports devices for packets and complains if the
> packet was not observed on the expected port and/ or observed on the
> other port. The received content of the data is compared against the
> send data sample.
> 
> Test suggested by Felix Maurer.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  tools/testing/selftests/net/hsr/.gitignore     |   1 +
>  tools/testing/selftests/net/hsr/Makefile       |   5 +
>  tools/testing/selftests/net/hsr/hsr_ptp.sh     | 109 ++++++
>  tools/testing/selftests/net/hsr/hsr_ptp_test.c | 495 +++++++++++++++++++++++++
>  4 files changed, 610 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/hsr/.gitignore b/tools/testing/selftests/net/hsr/.gitignore
> new file mode 100644
> index 0000000000000..849eecb84c974
> --- /dev/null
> +++ b/tools/testing/selftests/net/hsr/.gitignore
> @@ -0,0 +1 @@
> +hsr_ptp_test
> diff --git a/tools/testing/selftests/net/hsr/Makefile b/tools/testing/selftests/net/hsr/Makefile
> index 2150e487ac7d7..5d0134ead65d7 100644
> --- a/tools/testing/selftests/net/hsr/Makefile
> +++ b/tools/testing/selftests/net/hsr/Makefile
> @@ -2,14 +2,19 @@
>  
>  top_srcdir = ../../../../..
>  
> +CFLAGS += -Wall -Wl,--no-as-needed -O2 -g
> +
>  TEST_PROGS := \
>  	hsr_ping.sh \
>  	hsr_prp_redbox.sh \
>  	hsr_redbox.sh \
>  	link_faults.sh \
>  	prp_ping.sh \
> +	hsr_ptp.sh \
>  # end of TEST_PROGS

If there is a new version. Please sort the test with alphabet order.

>  
>  TEST_FILES += hsr_common.sh
>  
> +TEST_GEN_FILES := hsr_ptp_test
> +
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/net/hsr/hsr_ptp.sh b/tools/testing/selftests/net/hsr/hsr_ptp.sh
> new file mode 100755
> index 0000000000000..034c635916f81
> --- /dev/null
> +++ b/tools/testing/selftests/net/hsr/hsr_ptp.sh
> @@ -0,0 +1,109 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +ipv6=false
> +
> +source ./hsr_common.sh
> +
> +optstring="h4"
> +usage() {
> +	echo "Usage: $0"
> +}
> +
> +while getopts "$optstring" option;do
> +	case "$option" in
> +	"h")
> +		usage $0

usage "$0"

> +		exit 0
> +		;;
> +	"?")
> +		usage $0
> +		exit 1
> +		;;

Thanks
Hangbin
