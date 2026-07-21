Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72CA379C32
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784658195; cv=none; b=LZvfRFlAqaTmiLSiRDLbiYPEhzpPjG2kASPoURLmSh0284FaU7TJuYpXQexspw0EZbLmUsn2FxJN55t83imTKfDQbJlxQjoviKeBLVnNHe8La3d10WAOQOon/3gQw4vaARC7mZI88tr+X2s32n524dEhnK2scyHx3zv0tq50xjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784658195; c=relaxed/simple;
	bh=MXx0cJgudWCwXHBBy9sk+fYSU8GKXy7BCw6vd1W+Hig=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PHMyhiJOij9rWfXFLTgfUkEGHD+kBEFw5WcO1DBfthEtNjEbmIx+3W6+A8r/UJyPUY8ei/Jn6BGMShPDEqzxaBPrxSSOA2fmZmhDNoIRuGWT6RDd4gPfZPHiniQu3/Ye8fCBb6diffz6X5Bw/55MJjPLF+vVp8/tyOw9/Agd5SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHHl2aZr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHHl2aZr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F7411F00A3A;
	Tue, 21 Jul 2026 18:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784658194;
	bh=MXx0cJgudWCwXHBBy9sk+fYSU8GKXy7BCw6vd1W+Hig=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hHHl2aZr/De+Uo022PslxHeCLl3P5gSea6JDx3loQeuNr5NrJG7rrjaJdkplckYx2
	 VPNczG18EhvlVYdh6sV2slskb7iQtHbnKDeElbSHn8kQrPkDZWpfI/fG3ZpoGngLSu
	 jWXXlhnAqFeCYDehHxdBF3/IPgVPY6HrRouVzrvsZKJ7Trhe7buHwPEF8r1DkqYIwh
	 5ddFlyTuoccRBOOXZ0ZSk/dy8mW4WbG7aA5Ai+Hd09AMM7LYAxvF0KHhgX+2RjHlEO
	 Sow7RCZylAt8xmmXc/Vez1DsqmGKA6/uvjydPepYZq9hJX6TbsS9/c1BX188j4ilOo
	 Ie+U0QQuMFtOg==
Date: Tue, 21 Jul 2026 11:23:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, horms@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v7 0/2] net: libwx: improve VF ethtool support
Message-ID: <20260721112313.0595d73a@kernel.org>
In-Reply-To: <75E1DE3E-66A0-41A5-8543-8C1B630DEF75@net-swift.com>
References: <20260710015925.34769-1-mengyuanlou@net-swift.com>
	<75E1DE3E-66A0-41A5-8543-8C1B630DEF75@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Jul 2026 14:59:46 +0800 mengyuanlou@net-swift.com wrote:
> Any comments on this series would be appreciated.

Read the documentation and the mailing list.
