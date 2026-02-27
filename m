Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F76820468E;
	Fri, 27 Feb 2026 02:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772159525; cv=none; b=GydsUWcnDIPlIwTgyBDAqJXfoo0G3M+/qUjNf5DjA7zaN7vOBQTsC2Ftlki657+d8gnkbYg7uWDomMOMexp7eu5ytN7Z0hT6dDZcqP02VLsv/m6fSmf0hxjeq3nrbo1pHPN602EVJvccJL02onn7r7pnTPTtAbqaTdMgP7C+0Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772159525; c=relaxed/simple;
	bh=WVdflQPkcOnbCuaSo6d2/GAGYClxUgm83n9ew4xrfe0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kvnNhFyJ2PjLWFMtsUT973JfQ+4Y5GGIRizPKahbZ2yaQFCm6fpBoaBbhLkEzerJ1TB8xbTIIYE/2oJibHVG36nk9qit8BT0wz5UCZIY0cZJs24JxtJGk5DQsZONHWnzHrKL/aLorhQohgB+n8bbXxk26/Z0C8NIhwhnwL/Cql8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0tnKHDv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0tnKHDv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10B61C116C6;
	Fri, 27 Feb 2026 02:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772159524;
	bh=WVdflQPkcOnbCuaSo6d2/GAGYClxUgm83n9ew4xrfe0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n0tnKHDvZb27MgZ1Wg+6JBOhJLWZ7RSeRZeMXQEizkm3oeDkOZwz2EdGyUX6wJu5F
	 wFelC20erRiTYWRm3N3pOptUVk8Eoawm1skQMpHDJq/VdQvRVH6pViG7g5emr1vKgJ
	 gpB1EDl+Bo/wNpsGQCYyWtanDmkXx6yMked1MuYYcOxmgsWAY1Xo0fk7lxof9NP34r
	 6pNsIVSvApMaD2TPEKeTrPSTcOUzbGo1kUD+cLtqmTG2RwT5jfF2zs1cz5RpgUC2Xx
	 MDaE/4QpgpWklFT47p/H9iMod2AdDmb8pS01ZTit6D+5JXPL29tBg8FtnLkYPG8cHS
	 LxQ8gq/m3vXKA==
Date: Thu, 26 Feb 2026 18:32:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Adam Young <admiyo@os.amperecomputing.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, Jassi Brar
 <jassisinghbrar@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Robert
 Moore <robert.moore@intel.com>, Len Brown <lenb@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Jeremy Kerr
 <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Sudeep Holla
 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
Subject: Re: [net-next v31 1/2] mailbox: pcc: functions for reading and
 writing PCC extended data
Message-ID: <20260226183203.4a1d808d@kernel.org>
In-Reply-To: <20260224231055.393329-2-admiyo@os.amperecomputing.com>
References: <20260224231055.393329-1-admiyo@os.amperecomputing.com>
	<20260224231055.393329-2-admiyo@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Feb 2026 18:10:51 -0500 Adam Young wrote:
> Adds functions that aid in compliance with the PCC protocol by
> checking the command complete flag status.
> 
> Adds a function that exposes the size of the shared buffer without
> activating the channel.
> 
> Adds a function that allows a client to query the number of bytes
> avaialbel to read in order to preallocate buffers for reading.

All the kdoc you're adding is misformatted, please run
./scripts/kernel-doc -Wall -none to error check

Please look around the kernel to see how well written kdoc looks like
-- 
pw-bot: cr
