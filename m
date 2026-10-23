Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720090;
	b=y5tfcYnnIuKChBjXeKC1Y8fHZeXi+mhIsLzOKZzSDRAx8Lmo6WTNY4zNOhB7Wda/ayyC
	 z3hnR3IJmxwkVzBiXPyaH27sEfh/JMU+kEnXdLfetmGwr6TMwGx93Eu2Xt+rkKi85lIjn
	 8+7rgy+Rr5NmCMUlGc2byB05ZJaTdVkS23SIltOQUvlvjfntHhg6MMLq7thSif9n+pQu8
	 SGOW3bew3FVBkeUfA1SKD0uukc430elOTcrsVOUytkaHZkKKiMzpF8Fb/k5mk2mZYOhNl
	 CdqHPfUlxC+3ggsK2naIGS2entB/Bf7861rQe8JT9OEY/1LWs5aRAF6nOBMN5D4OGRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720090;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=K974vEkl7HviH9zH+bkMsQvo+7f18yyRhOODa6fRHas=;
	b=ZC2eRznu1N4y/hH5ONRhAhCv3jPMStISWRu2VIQuFczhHJgNoGJnzsikx6m2GCF6Rkgc
	 RpHOdGz/MftQ2yVM8dSu6tChdJOIAacfiUTZOb0X3Qbhf5z5qeEk2bbBtgKiDPtWJuPDZ
	 HC2CE7AZ/yZRLY7P2Qf7GpmHpHbFPm8QPkMXlO/y6iZTV4e9ypkcsV6HCEqB6bZj2JnlX
	 L2LYVrfTCyJRWwU4P3bt37C85lllHBFa9/SjYtRHmzOsErt3c61wzwj7o+OAEm3YPcQdR
	 WGwySo/Jj63cwWGGpLPvmcTjw8leS53ed96MARCLBcPhtgg117WvwFpR6g2oJ4gPKAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mzlksBhs;
	arc=none smtp.remote-ip=91.218.175.11
Received: from mta0.migadu.com (out-11.mta0.migadu.com [91.218.175.11])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409F6606A31F
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 01:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 409F6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=mzlksBhs
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=VPNQpDtmsXoZKn9VI7oWOvmenOOysxW0h45w0IjOb3A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792720086; v=1; x=1793324886;
 b=mzlksBhsOKZ7TfQewEzzrNsWjwR2XIdgDP6GxZdOK4P7kWvAQ5SYDbGF3gzAywwpGzvVFW5B
 Vp1h7pCw9L7CIXNIae9od5XmAi+nSPwanQFGPkpSt9aRFhubdsXxU/nlNszcgyopGqtBTz7NB37
 E4o2g+LcZc71C0xWa1NIZ8ZE=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id cd0afe3d7227279f;
	Fri, 23 Oct 2026 01:48:06 +0000
X-Mizu-Trace-ID: cd0afe3d7227279f
X-Migadu-Flow: FLOW_OUT
Date: Fri, 23 Oct 2026 09:47:52 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Xia Yan <yana06070@163.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, horms@kernel.org, kuba@kernel.org,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	pabeni@redhat.com, shuah@kernel.org
Subject: Re: [PATCH net v3 2/2] selftests: net: check veth carrier after
 changing channel counts
Message-ID: <atq8yKbnqtLBVucH@fedora>
References: <20261022085842.2527-1-yana06070@163.com>
 <20261022085842.2527-2-yana06070@163.com>
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
In-Reply-To: <20261022085842.2527-2-yana06070@163.com>

Hi Yan Xia,
On Thu, Oct 22, 2026 at 04:58:42PM +0800, Xia Yan wrote:
> Extend veth.sh to check carrier state after changing channel counts.
> A running interface must keep carrier off while its peer is down.
> 
> Cover up/up and both mixed up/down combinations with GRO on and off.
> Resize RX and TX queues in both directions on each endpoint, and check
> that rejecting an out-of-range request also preserves carrier state.
> Use two queues explicitly so these cases also run on single-CPU systems.
> 
> Keep these cases with the existing veth tests and reuse their namespace
> setup, cleanup and aggregate failure status. Only check LOWER_UP on
> running interfaces, where that flag exposes carrier state.
> 
> The four mixed up/down cases fail with the unfixed driver. All six
> carrier cases and the existing checks pass with the fix.
> 
> Assisted-by: LLM
> Signed-off-by: Xia Yan <yana06070@163.com>
> ---
> 
> Notes:
>     Changes in v3:
>     - Move the six carrier cases into veth.sh following review of v2.
>     - Reuse namespace setup, cleanup and error reporting.
>     - Allow explicit queue counts in create_ns().
> 
>     v2: https://lore.kernel.org/netdev/20261020135544.24441-1-yana06070@163.com/
> 
>     Testing on the v2 baseline 513444cc62e2:
>     - Complete default veth.sh on x86_64 QEMU/KVM, three vCPUs:
>       before: 57 checks pass, four mixed up/down carrier checks fail;
>       after: all 61 checks pass. The 55 existing checks pass on both.
>     - bash -n and git diff --check pass.
>     - If creating the veth pair fails, the case is skipped without
>       masking failures from earlier test cases.
> 
>     Both patches also apply to net/main ffdf678dd166
>     (application check only, checked on 2026-10-22).
> 
>     The QEMU guests failed to power off cleanly (initramfs issue) after
>     the tests completed; the exit codes above are the veth.sh results.
> 
> 
>  tools/testing/selftests/net/veth.sh | 84 ++++++++++++++++++++++++++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
> index 8b867e0..901ba51 100755
> --- a/tools/testing/selftests/net/veth.sh
> +++ b/tools/testing/selftests/net/veth.sh
> @@ -41,13 +41,15 @@ create_ns() {
>  		ip -n $ns link set dev lo up
>  	done
>  
> -	ip link add name veth$SRC type veth peer name veth$DST
> +	ip link add name veth$SRC "$@" type veth peer name veth$DST "$@" || return 1
>  
>  	for ns in $SRC $DST; do
>  		ip link set dev veth$ns netns $BASE$ns up
>  		ip -n $BASE$ns addr add dev veth$ns $BM_NET_V4$ns/24
>  		ip -n $BASE$ns addr add dev veth$ns $BM_NET_V6$ns/64 nodad
>  	done
> +
> +	return 0
>  }
>  
>  __chk_flag() {
> @@ -130,6 +132,80 @@ chk_channels() {
>  	fi
>  }
>  
> +chk_carrier() {
> +	local target=$1
> +	local state=$2
> +	local expected=$3
> +	local carrier=0
> +	local link
> +
> +	# IFF_LOWER_UP is reported only for running interfaces.
> +	[ "$state" = up ] || return 0
> +
> +	if ! link=$(ip -n $BASE$target -o link show dev veth$target); then
> +		echo " fail - cannot read veth$target link state"
> +		return 1
> +	fi
> +	case "$link" in
> +		*LOWER_UP*) carrier=1 ;;
> +	esac
> +	if [ "$carrier" -ne "$expected" ]; then
> +		echo " fail - veth$target carrier is $carrier, expected $expected"
> +		return 1
> +	fi
> +}
> +
> +chk_channels_carrier() {
> +	local src_state=$1
> +	local dst_state=$2
> +	local gro=$3
> +	local expected=0
> +	local err=0
> +	local target count
> +	local msg="carrier after channel change ($src_state/$dst_state, GRO $gro)"
> +
> +	if ! create_ns numtxqueues 2 numrxqueues 2; then
> +		printf "%-60s" "$msg"
> +		echo " skip - cannot create veth pair"
> +		cleanup
> +		return
> +	fi
> +
> +	ip -n $NS_SRC link set dev veth$SRC "$src_state" || err=1
> +	ip -n $NS_DST link set dev veth$DST "$dst_state" || err=1
> +	ip netns exec $NS_SRC ethtool -K veth$SRC gro "$gro" >/dev/null || err=1
> +	ip netns exec $NS_DST ethtool -K veth$DST gro "$gro" >/dev/null || err=1

Why do you do gro setting in rx/tx set ups?

Thanks
Hangbin
