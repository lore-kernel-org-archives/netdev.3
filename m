Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793174500;
	b=JfxAc8KRRrLCyZiVJ/MHJtMYevwx1I+NZsb0fPwtCm3wurS2MW88tZojI2OE3Z9SWjmJ
	 fOJn4LzT8O6epxVtMN1ZAWEMrquj0N6mzcalfUFJN78zYgWgt4vEsOYU1oMfsyI30c4Vi
	 F8EnU5FgJuPcnqqE6o1uGBabYidIUrTc9fGO/Usth/3vVueUn56oDhcfBXbvK5RpOm/ek
	 Cws/NsiXUIPGW/bz53TBVPHmHTr+PRz3anVM8uuHYjEMfiYJ/ng+3VvaFN2UaVpr5tfhB
	 UivlsIkisVeElEacALY5732i1/UwZTiB12dB66+5bWjCdFuhS1K0kfyDz6oONgDbdeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793174500;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=lWJp2qxHjJw0q3oxbZk5M4LsR6REgEMt9kjbiGvBHnM=;
	b=UOt7zRKR0VwJidDghWJbrwOBBVHSWkQV805eAtB4pkeowh4TWemsuDpG9E/QxqQZyLEk
	 NYPNAQ3rLwR/6t9KI1bEXM8i5kPleRXnZpzjW0k7V0MfpUNWq8P8KY/e9ONKUiAayteqw
	 kogj9/WWHnsELBP+i5FkpsrNAlt8PAKkxTbKZ2NrRUKNtFMTsFnOJDECwau1TzRd/kSld
	 p5sHvzygyTXQJYUjLkXv98zn1UUhOHrDArXF78Xa0Sz+Zyif6VGA7XSpOdt020fIcA89Y
	 FVxqfC31MfKN79ATWhC/MSObsbUxOg09acshBGhsiWX/v3yOSOYmi8AliAodFrQViGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aJ6Wn3eo;
	arc=none smtp.remote-ip=91.218.175.102
Received: from mta0.migadu.com (out-102.mta0.migadu.com [91.218.175.102])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E3606A31E
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:01:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 938E3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aJ6Wn3eo
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lWJp2qxHjJw0q3oxbZk5M4LsR6REgEMt9kjbiGvBHnM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793174491; v=1; x=1793779291;
 b=aJ6Wn3eo5OvkveAQs9c3sJ94OXCM3uJTJebR1SN1Pma2/yMP9RMEEknKYoyjhk7iUnmoEv5q
 7sIMZWP7vk4mRWOVid2RVsyCITWgPZOOpk+V093NPR7zJu35OIW7+p9uIucCHuGMg4jNGhEf7NK
 3j6CyhfavDIS23cL+5dkkCzc=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 8aa38f60f137e166;
	Wed, 28 Oct 2026 08:01:31 +0000
X-Mizu-Trace-ID: 8aa38f60f137e166
X-Migadu-Flow: FLOW_OUT
Date: Wed, 28 Oct 2026 16:01:13 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Justin Iurman <justin.iurman@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hangbin Liu <liuhangbin@kylinos.cn>
Subject: Re: [PATCH 0/3] net: ioam6: makes IOAM insertion transparent to IPv6
 ECMP
Message-ID: <auGryXdPv2mx0qlp@fedora>
References: <20261028-ipv6_ioam_ecmp-v1-0-9b6715b6f4c0@kylinos.cn>
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
In-Reply-To: <20261028-ipv6_ioam_ecmp-v1-0-9b6715b6f4c0@kylinos.cn>


On Wed, Oct 28, 2026 at 01:45:28PM +0800, Hangbin Liu wrote:
> This series makes IOAM insertion transparent to IPv6 ECMP, as required
> by RFC 9486 (C2): a packet carrying IOAM options must be forwarded
> along the same path as the identical packet without them.

Sorry, forgot to add target repo "net". I will add it in next version.

Thanks
Hangbin
