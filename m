Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1028640B
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 14:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777560532; cv=none; b=gQ0d+zv0Ibv/PJsa2RhydyXnh0kMITeZUOxkePmLyPLIFDXTHrCH7q3cvY0FE0ilgUvlTrJwm94H+mh9xTMsFObXQDV2izd0BaZOsg+omQyPQ1Xoq3RRVANK+nJUB0vM5aNDE4gw1K+tgyA+5Qc9NcRc49790O+dO5PLP9IcAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777560532; c=relaxed/simple;
	bh=y8zJk9caf7v4JlJgjE0gjutEn8ottL/lwMgaKWlC90M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VLd47Ump1+VQkMAgNXaH/UgpJbn4PDG1OR9kbdqETO9FX1RP+kUecjcbCAtQ0tjF/tQ7ku7PTFmBt14+OYJVyKuTnanCxT4OHuApX2LqvFaGM7I/haRqqZnypZ0Vz00/Bj8CuYeOUAVlWL3568FKxUtfhGkE/TYPxdn0Ta1q8ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX/WfblH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX/WfblH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BED97C2BCB3;
	Thu, 30 Apr 2026 14:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777560532;
	bh=y8zJk9caf7v4JlJgjE0gjutEn8ottL/lwMgaKWlC90M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JX/WfblH6PuwC/gGATZ14PS7j4Py7vglrSpWgh2wP6/Y7DQ44WO+hdIcB1A2TBf8z
	 DHR+atbgR7pWusLzL6DqEnmXEDS7Lond3ywE1C7nZl+4N5kMNQFnNC8ScRisgkstkC
	 DiYKyY5buUrQ7/w2EPbaDOaHM0SkKGrGkUBqkHbHBusoXnJ4sSzdlU/NrcGXLPhfOD
	 NEpA78Qx6jh0JyJNzKUxs2uvCkwiPlJiCY5SUPsDZ90ZY3/ov+gQkjyn6zXxs5Z4hU
	 OX9dyyMGPjsyOP1ffE/TPfZbJzAnvWDNVyzz/t/a+PiEAwzJFN+uVOCBCnfwFyefO1
	 xvYG3xnKkkfjw==
Date: Thu, 30 Apr 2026 07:48:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH 0/5] ice: five small fixes and cleanups
Message-ID: <20260430074850.78ed5bdf@kernel.org>
In-Reply-To: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
References: <20260430122602.126722-1-aleksandr.loktionov@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Apr 2026 14:25:57 +0200 Aleksandr Loktionov wrote:
> Subject: [PATCH 0/5] ice: five small fixes and cleanups

Please tag your submissions with iwl-* if you are cross posting.
-- 
pw-bot: au
