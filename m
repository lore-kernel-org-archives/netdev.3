Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7128D408020
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 16:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539639; cv=none; b=khJfb0frPEHaUdx85vRq8Z+S/BmYN41XGvb7R0aNz0xujVrpkf5daKZK7ulWzlcU2vNqyWD7QuzJ05E6UimodwH9/y8V+/r5LEdnzb7DZTfhZVF2jbxf7FOuBV2OxuLFJffPuBnxEr9M05w2b9ET+bDPikxJ0MrLstNN1F24nJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539639; c=relaxed/simple;
	bh=ARVJgllKDAfCGQcqC79U5S6w/TGFl61Cpk3aif7gY7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FM/dbCTODzpmS1tsutwYfhwfdEYpPTruvFYxNPFjVQGz2yIQnsHPQEXmfT1yPcXX6rwhQvlabTx+X7fzWrDZORduUc41gKR5krHExMJr0USarhbbUydOJnKaRgqjH3lRX1OEAQN3XbX7OkOSD9JjMaSCRZ8gMQKKVOQdJukDMws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxmLKqCQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxmLKqCQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CD01F000E9;
	Mon, 15 Jun 2026 16:07:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781539638;
	bh=qqlI/1HrvbOTcVtHla0mZN8srz7IMjrDYh+TSI8WFoM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DxmLKqCQL2qZSLhRKyH6YVy0X0JzGZQ0dSDy3si70S6INgM8//NeveOLZb2JHcAG9
	 0eMpw+EaiimzOyK1eMo7Ij/9CCZf63Non8FOx154yjZ5nIFFyYEdetz2ntezeJIXb0
	 qdMPTtX/ZpGj0aVs+JyL+tzVFNKxmtthAETb82CjQY5oHLmnr8VcnRVX5bAs5rsuJe
	 qOgRBDoLHxQ1yuWYZyP70I4jd3zpyoD6TXSuXsFVtUfO9m0qCt//snYICqArJ7jbo/
	 mK6QPPwL7QLQ6JD1XxsfX7FteKH5dXW4686xeshK17IbXRBV9py8kEcAmmvgFTdaEq
	 HGLP1zi2gIhXQ==
Date: Mon, 15 Jun 2026 09:07:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, horms@kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next v5 0/3] net: libwx: improve VF ethtool support
Message-ID: <20260615090717.39977005@kernel.org>
In-Reply-To: <20260615104849.60444-1-mengyuanlou@net-swift.com>
References: <20260615104849.60444-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 18:48:46 +0800 Mengyuan Lou wrote:
> This series improves ethtool support for Wangxun VF drivers
> (ngbevf and txgbevf) in libwx.

net-next is closed, please repost after the merge window
-- 
pw-bot: cr
