Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59F4472528
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 17:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784656365; cv=none; b=qf0XCDzBHB8nVW4qodYxnu9EBpXROnQEeya5SB3c++NsUjhKRn6j1HJZv5EgAmrhnVXgIfVcSbbpA/gCIN61lqjzsicJxrGZS2YTs5qGyRgU3zwOLkHQRyOs+BoqWHgOAZdTxp0LHPGy5LqOZZrIdFrhd0abDU8eBfgXvONnMPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784656365; c=relaxed/simple;
	bh=JXejyfKy5dpUU7qq+FQcqMrhqkZdMzn8InkEzAWwjW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K4NJdDc9EgBIr4VGgAHdR41QHcSW7FnBMIYZ3Lly9/Qfi31Pvb5q1QOZj4q0u8FL7qbA9plq4IAtqSqupz7b+5cFN1u5RW5yy2MjsMYcbw+A7vAhe6cBDbQZqE9eR7CNw7/OSsdWFlV4LSwCEG2xuB1r06RjJ9bNtXQixNdAWT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8eTAFZ3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8eTAFZ3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73D041F00A3F;
	Tue, 21 Jul 2026 17:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784656364;
	bh=JXejyfKy5dpUU7qq+FQcqMrhqkZdMzn8InkEzAWwjW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M8eTAFZ3sEjUc1lyx6sdesU51AAxrZF9Gu7lN5tecQATdBI9WtISReK5zvmDdQIkk
	 JEaXhUmAYjS59lyULYQVLQxwHr/FD8IFCTtTyvb9OWGcAeptFZoh3pbnIB30w9D5tO
	 h6sA+qgZx1mkAu9z44qPA/UpBcBI3tw50IQrnSBU3SMFalQ1Qce4+C0oy0j0WQYUZi
	 mNqAzCLBh1O07NsrGYexsTEV+jkFLvf8hfRiAVDhwJTp9/C9junNynjpvRvqTPC4st
	 LfbC8FF9Wc72vlq9xcAId19NuclysVXGD0jz0TvEB5z58zAo+Q331HB9dksiEZk3/8
	 i+yLZaHKo1EGQ==
Date: Tue, 21 Jul 2026 10:52:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org
Subject: Re: [PATCH net-next v5] selftests/net/openvswitch: add ICMPv6 echo
 type match test
Message-ID: <20260721105243.23183dd0@kernel.org>
In-Reply-To: <20260720032448.3709753-1-houminxi@gmail.com>
References: <20260709120541.3556748-1-houminxi@gmail.com>
	<20260720032448.3709753-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Jul 2026 23:24:48 -0400 Minxi Hou wrote:
> Gentle ping on this patch. It's been about 10 days without review
> comments. Please let me know if there are any issues or if a respin
> is needed.

Read the mailing list. There was an announcement.
You're just wasting our time with such stupid pings :/
