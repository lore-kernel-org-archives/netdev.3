Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645344B4879;
	Tue,  8 Sep 2026 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900289; cv=none; b=TCK0/tZckjwDPyvw1gWUHhm3cQLAW/4cXqvk6BtVujhkI8NuCFcmNaGXyy4pEqUvjH13hz55/q2Q6RMmJVXXmYz6WlsVUSKCPBs/c/afIakvNP82FStRnX9QbQNqML0QkW46HQU1x4MusKROOUgupNnCtn7dH9w62XHJnYP3OEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900289; c=relaxed/simple;
	bh=IAx4DAYCGqMT4FZpmvXqersF/0q0U6q+bWhfa4I2PcM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7KIXja5u5AOUrDpf/qIGpP/kBYo65JZrgCaNyX09hI2ygb2nCJUAgWnvRXz95aEZEx6as01blNeyF9PTRNRPBm8UJA9pkbVOZMOG2AShRTGpguap0cLm4ZdxwOzpXK1JBbqtHe95Ht1hVI+h2HT1lmosI9hWJpP6CdXJu7JSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1FybzVZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1FybzVZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEDF61F00A3A;
	Tue,  8 Sep 2026 20:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900288;
	bh=JXLwFnkqdE6J67EAMoGXafcMkRcYwlwH8UH+rj+BfS8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=j1FybzVZ62PixgCpdcAMz2Eb68ClkUs8u85JeRschAdcYNfcOFlHlvCMm+oBBf7p1
	 FpgS993NQDQ/DnxPrSseFszqSIEuVfyRz1KEQPrF77WLVrsQ3T9H9bsTZTzablQ1i6
	 nDO4QCIfeM8BC6VqAygbdUGzsFCZmDxBYxLTf7975UN185zu18e0+BcZSipcFVU9Ra
	 jhzxkqONrT69Omfq2MXVc7x544gEqjCLsuurOJ1ppPU3iw/walG2nSlRmpP6M6Z7Ak
	 Xye0DTHnB2mqGsiTztUmrR3I5GfETqk4ItSliAlX8in75V63FZ+VBC/zZmGJGPpNVp
	 UzH0bL8un4CjA==
Date: Tue, 8 Sep 2026 13:44:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Raju Rangoju <Raju.Rangoju@amd.com>,
 Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Jian Shen <shenjian15@huawei.com>, Jijie
 Shao <shaojijie@huawei.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-usb@vger.kernel.org, Yury Norov
 <ynorov@nvidia.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andrew
 Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 9/9] MAINTAINERS: co-maintain linkmode.h under BITMAP
Message-ID: <20260908134446.58796a05@kernel.org>
In-Reply-To: <20260907215439.409858-10-ynorov@nvidia.com>
References: <20260907215439.409858-1-ynorov@nvidia.com>
	<20260907215439.409858-10-ynorov@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 17:54:38 -0400 Yury Norov wrote:
> The file is largely a wrapper around bitmap.h. List it under BITMAP
> section for co-maintenance.

I don't think this is appropriate, configure lore+lei if you want 
to see the changes.
