Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200D3430BA3
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 01:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772326866; cv=none; b=IoXV/F7vs9cX8xhja9hkrhLLSHmaeVFBC9dxu7j0PaAms87xRnBxnsYe6AxJYy/6b2b/PTnRfvwpK24ocwXdgX1zptGah0ixoIlD02DWxr8zUpb8dmAhqhFcMSlXO2Kd/jUkmD19TgVPNCLmoqRVlqNF+jWc73mgPVzSZrdu/I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772326866; c=relaxed/simple;
	bh=H1zg0UzOZJupIkEti740eZmtrL7tbhwa84DDVLY4obY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q0qtYBa1Dda4W/MaGvdffw6vri8nzEvNbKLfTBkgpOgdwvYe9nTqZ/oRM2usJAQZxyggBiV0lnnZxNGqDAZZcA2ahfdcxGZwnFwBqUhLAafM4sGUYIi44jEGC0UXGaSUGS19eHIc7ZymUEijx7s0wih4qSHdWDwyaaoTT+5jIQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeDZpzwx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeDZpzwx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B879C19421;
	Sun,  1 Mar 2026 01:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772326865;
	bh=H1zg0UzOZJupIkEti740eZmtrL7tbhwa84DDVLY4obY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QeDZpzwxTnCCQN6wWwKjiNHX7OwyUknAQYt8V4UJfJ7mqyZ5j3l1Wnb8ArCfq1e+t
	 z12GX2yQDgdnci+FA3b+4COnggPg5Z+WpVLJH65feWW5/JjE1A1KudkPcP3a1B+0cr
	 Y0bmD1Ns8x3V+mhqKgzYfHIUAp1djPv9R41t4P/9agQkSOIxBeX148S2Gt9ZVN/0+d
	 B57J5EV3xCfKx2qJRIAnD51VvXG3tAx8DpxdMv2pVGqqAqYVvNey2Bkt+/F3R4N2p3
	 bQl5EO+o3ISviKW00DhJyLqEdQ6xCpmwjdI2uIltWZM97tJSDFkw8qD2qDg6mETLZR
	 SYLH8H2UG+R/w==
Date: Sat, 28 Feb 2026 17:01:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antonio Quartulli <antonio@openvpn.net>
Cc: netdev@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 0/9] pull request: ovpn 2026-02-28
Message-ID: <20260228170104.1ec4c133@kernel.org>
In-Reply-To: <433139b8-3aea-4db1-8ed6-959ac445cd27@openvpn.net>
References: <20260227235955.660-1-antonio@openvpn.net>
	<433139b8-3aea-4db1-8ed6-959ac445cd27@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 21:49:08 +0100 Antonio Quartulli wrote:
> On 28/02/2026 00:59, Antonio Quartulli wrote:
> > Hello netdev team!
> > Here is our first batch of new features for ovpn.  
> 
> Please drop this PR.
> 
> The automatic checks on patchwork have highlighted a few things worth 
> fixing (and the AI even found a real bug in the selftest Makefile!).
> 
> Will resend the PR after fixing all issues.

Hi! I am trying to add ovpn to our netdev CI (Fedora 43). 
This is what I see without this series applied:

TAP version 13
1..7
# timeout set to 45
# selftests: net/ovpn: test-chachapoly.sh
# Creating interface tun0 with mode 1
# Creating interface tun1 with mode 0
# Creating interface tun2 with mode 0
# Creating interface tun3 with mode 0
# Creating interface tun4 with mode 0
# Creating interface tun5 with mode 0
# Creating interface tun6 with mode 0
# unexpected base64 error1: BASE64 - Invalid character in input (-44)
# Error: invalid arguments.
# 

And then it hangs. When I run the tests with this series applied
its still broken but at least doesn't hang (see below)

What am I missing?

# make -C tools/testing/selftests/ TARGETS=net/ovpn run_tests
make: Entering directory '/srv/vmksft/testing/wt-test/tools/testing/selftests'
make[1]: Entering directory '/srv/vmksft/testing/wt-test/tools/testing/selftests/net/ovpn'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory '/srv/vmksft/testing/wt-test/tools/testing/selftests/net/ovpn'
make[1]: Entering directory '/srv/vmksft/testing/wt-test/tools/testing/selftests/net/ovpn'
TAP version 13
1..8
# timeout set to 45
# selftests: net/ovpn: test-chachapoly.sh
# Creating interface tun0 with mode 1
# Creating interface tun1 with mode 0
# Creating interface tun2 with mode 0
# Creating interface tun3 with mode 0
# Creating interface tun4 with mode 0
# Creating interface tun5 with mode 0
# Creating interface tun6 with mode 0
# kernel error: Unknown attribute type
# netlink reports error (-7): Invalid input data or parameter
# failed to send netlink message: Invalid argument (-22)
# cannot add peer to VPN: 1 10.10.1.2 1 5.5.5.2
# Cannot execute command: Invalid argument (-22)
not ok 1 selftests: net/ovpn: test-chachapoly.sh # exit=234
/srv/vmksft/testing/wt-test/tools/testing/selftests/kselftest/runner.sh: line 50: : No such file or directory
# timeout set to 45
# selftests: net/ovpn: test-close-socket-tcp.sh
# Deleting interface tun1 ifindex 3
# Deleting interface tun2 ifindex 3
# Deleting interface tun3 ifindex 3
# Deleting interface tun4 ifindex 3
# Deleting interface tun5 ifindex 3
# Deleting interface tun6 ifindex 3
# Creating interface tun0 with mode 1
# Creating interface tun1 with mode 0
# Creating interface tun2 with mode 0
# Creating interface tun3 with mode 0
# Creating interface tun4 with mode 0
# Creating interface tun5 with mode 0
# Creating interface tun6 with mode 0
# connected
# Connection received!
# kernel error: Unknown attribute type
# netlink reports error (-7): Invalid input data or parameter
# failed to send netlink message: Invalid argument (-22)
# cannot add peer to VPN
# Cannot execute command: Invalid argument (-22)
# kernel error: Unknown attribute type
# netlink reports error (-7): Invalid input data or parameter
# failed to send netlink message: Invalid argument (-22)
# cannot add peer to VPN: 1 5.5.5.2
# Cannot execute command: Invalid argument (-22)
not ok 2 selftests: net/ovpn: test-close-socket-tcp.sh # exit=234
/srv/vmksft/testing/wt-test/tools/testing/selftests/kselftest/runner.sh: line 50: : No such file or directory
# timeout set to 45
# selftests: net/ovpn: test-close-socket.sh
# Deleting interface tun1 ifindex 3
# Deleting interface tun2 ifindex 3
# Deleting interface tun3 ifindex 3
# Deleting interface tun4 ifindex 3
# Deleting interface tun5 ifindex 3
# Deleting interface tun6 ifindex 3
# Creating interface tun0 with mode 1
# Creating interface tun1 with mode 0
# Creating interface tun2 with mode 0
# Creating interface tun3 with mode 0
# Creating interface tun4 with mode 0
# Creating interface tun5 with mode 0
# Creating interface tun6 with mode 0
# kernel error: Unknown attribute type
# netlink reports error (-7): Invalid input data or parameter
# failed to send netlink message: Invalid argument (-22)
# cannot add peer to VPN: 1 10.10.1.2 1 5.5.5.2
# Cannot execute command: Invalid argument (-22)
not ok 3 selftests: net/ovpn: test-close-socket.sh # exit=234
/srv/vmksft/testing/wt-test/tools/testing/selftests/kselftest/runner.sh: line 50: : No such file or directory
# timeout set to 45
# selftests: net/ovpn: test-float.sh
# Deleting interface tun1 ifindex 3
# Deleting interface tun2 ifindex 3
# Deleting interface tun3 ifindex 3
# Deleting interface tun4 ifindex 3
# Deleting interface tun5 ifindex 3
# Deleting interface tun6 ifindex 3
# Creating interface tun0 with mode 1
# Creating interface tun1 with mode 0
# Creating interface tun2 with mode 0
# Creating interface tun3 with mode 0
# Creating interface tun4 with mode 0
# Creating interface tun5 with mode 0
# Creating interface tun6 with mode 0
# kernel error: Unknown attribute type
# netlink reports error (-7): Invalid input data or parameter
# failed to send netlink message: Invalid argument (-22)
# cannot add peer to VPN: 1 10.10.1.2 1 5.5.5.2
# Cannot execute command: Invalid argument (-22)
not ok 4 selftests: net/ovpn: test-float.sh # exit=234
/srv/vmksft/testing/wt-test/tools/testing/selftests/kselftest/runner.sh: line 50: : No such file or directory
# timeout set to 45
# selftests: net/ovpn: test-large-mtu.sh
# Deleting interface tun1 ifindex 3
# Deleting interface tun2 ifindex 3
# Deleting interface tun3 ifindex 3
# Deleting interface tun4 ifindex 3
# Deleting interface tun5 ifindex 3
# Deleting interface tun6 ifindex 3
# Creating interface tun0 with mode 1
# Creating interface tun1 with mode 0
# Creating interface tun2 with mode 0
# Creating interface tun3 with mode 0
# Creating interface tun4 with mode 0
# Creating interface tun5 with mode 0
# Creating interface tun6 with mode 0
# kernel error: Unknown attribute type
# netlink reports error (-7): Invalid input data or parameter
# failed to send netlink message: Invalid argument (-22)
# cannot add peer to VPN: 1 10.10.1.2 1 5.5.5.2
# Cannot execute command: Invalid argument (-22)
not ok 5 selftests: net/ovpn: test-large-mtu.sh # exit=234
/srv/vmksft/testing/wt-test/tools/testing/selftests/kselftest/runner.sh: line 50: : No such file or directory
# timeout set to 45
# selftests: net/ovpn: test-mark.sh
# Deleting interface tun1 ifindex 3
# Deleting interface tun2 ifindex 3
# Deleting interface tun3 ifindex 3
# Deleting interface tun4 ifindex 3
# Deleting interface tun5 ifindex 3
# Deleting interface tun6 ifindex 3
# Creating interface tun0 with mode 1
# Creating interface tun1 with mode 0
# Creating interface tun2 with mode 0
# Creating interface tun3 with mode 0
# kernel error: Unknown attribute type
# netlink reports error (-7): Invalid input data or parameter
# failed to send netlink message: Invalid argument (-22)
# cannot add peer to VPN: 1 10.10.1.2 1 5.5.5.2
# Cannot execute command: Invalid argument (-22)
not ok 6 selftests: net/ovpn: test-mark.sh # exit=234
/srv/vmksft/testing/wt-test/tools/testing/selftests/kselftest/runner.sh: line 50: : No such file or directory
# timeout set to 45
# selftests: net/ovpn: test-tcp.sh
# Deleting interface tun1 ifindex 3
# Deleting interface tun2 ifindex 3
# Deleting interface tun3 ifindex 3
# Creating interface tun0 with mode 1
# Creating interface tun1 with mode 0
# Creating interface tun2 with mode 0
# Creating interface tun3 with mode 0
# Creating interface tun4 with mode 0
# Creating interface tun5 with mode 0
# Creating interface tun6 with mode 0
# connected
# Connection received!
# kernel error: Unknown attribute type
# netlink reports error (-7): Invalid input data or parameter
# failed to send netlink message: Invalid argument (-22)
# cannot add peer to VPN
# Cannot execute command: Invalid argument (-22)
# kernel error: Unknown attribute type
# netlink reports error (-7): Invalid input data or parameter
# failed to send netlink message: Invalid argument (-22)
# cannot add peer to VPN: 1 5.5.5.2
# Cannot execute command: Invalid argument (-22)
not ok 7 selftests: net/ovpn: test-tcp.sh # exit=234
/srv/vmksft/testing/wt-test/tools/testing/selftests/kselftest/runner.sh: line 50: : No such file or directory
# timeout set to 45
# selftests: net/ovpn: test.sh
# Deleting interface tun1 ifindex 3
# Deleting interface tun2 ifindex 3
# Deleting interface tun3 ifindex 3
# Deleting interface tun4 ifindex 3
# Deleting interface tun5 ifindex 3
# Deleting interface tun6 ifindex 3
# Creating interface tun0 with mode 1
# Creating interface tun1 with mode 0
# Creating interface tun2 with mode 0
# Creating interface tun3 with mode 0
# Creating interface tun4 with mode 0
# Creating interface tun5 with mode 0
# Creating interface tun6 with mode 0
# kernel error: Unknown attribute type
# netlink reports error (-7): Invalid input data or parameter
# failed to send netlink message: Invalid argument (-22)
# cannot add peer to VPN: 1 10.10.1.2 1 5.5.5.2
# Cannot execute command: Invalid argument (-22)
not ok 8 selftests: net/ovpn: test.sh # exit=234
