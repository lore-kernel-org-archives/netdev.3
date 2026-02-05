Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EFD288C13;
	Thu,  5 Feb 2026 02:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770258270; cv=none; b=c+kJTipxtnoRYQ9789m3ryhhMRs1+XKpkoepvNVsytklCRDRfSZ5DoQhjib77lTmuq9VWznT1eCBAJ5dU3gva9J72nRz7G/hXs1gQHE3zz916yR8jDFssBeQG55nXKYNU8LWwjKrKyJBDE119qq5hGNTamLOO6lcMoCPNSme62A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770258270; c=relaxed/simple;
	bh=FPPipEkqgj8j9tt7VeSeBz1ebQLcdjb6a2KikrbZgeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dS+dlIsUDyqmiD15NypkBAa7jXH8H3cheVnRkd4Xaj12Pre0I8V6oL8IiFbl2RWAk3t6fTzRizmF15A7EjwcL4+mZu1ccnh1B4VDxDDZIrX62TbEC7iQRp/l2UZ+pUlQw43TRr5JyN9ency4DoLH9ACVMxN/i6JJaSfWXGW+v7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIWEwW30; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIWEwW30"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6BE0C4CEF7;
	Thu,  5 Feb 2026 02:24:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770258270;
	bh=FPPipEkqgj8j9tt7VeSeBz1ebQLcdjb6a2KikrbZgeI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QIWEwW30voIemro73wMfKw1g0wBw+qm3APAe0Zwe2/KXAvFQX0khg8VWrAG5piCNB
	 fz2dFKSQBaiCRjX5HaOT4L7CJNTfJ+x8y4Sm4nrj/HyCb/IgL9bs9+RZTRb1qW1dnt
	 ZUcmXF8nqAQPXDDAu2PHvaKy1RZBTNMm1QP/hNmFKCSEE7NVRUVUw2F1nTCr7QrW2a
	 X1JHwl94d3puJKGd1rFVn2wqf86S3HbFFzVdUG9b2h9av0DwWU/BpjmNZqsRKAtgpD
	 7pQuQZ4VfGj8KrBvk2poJOBp7CK6X60CQ7vZP5bTu3BwtkZx0qQ+PxF6Q6Zk0poF/O
	 JFRV+W3Bf+TJA==
Date: Wed, 4 Feb 2026 18:24:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <sgoutham@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next v8 00/13] NPC HW block support for cn20k
Message-ID: <20260204182428.05a77b13@kernel.org>
In-Reply-To: <20260202074607.2535569-1-rkannoth@marvell.com>
References: <20260202074607.2535569-1-rkannoth@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Feb 2026 13:15:54 +0530 Ratheesh Kannoth wrote:
>  27 files changed, 7286 insertions(+), 471 deletions(-)

The merge window is near, I think there's zero chance this will get
merged for 7.0. Could you wait with v9 until 7.0-rc1 ?

I'll release the remaining AI bot reviews now..
