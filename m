Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC54347C6
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405740; cv=none; b=gfDPKXUlHsFXX6TaElnLkFEdXsUetSWpXARE02PTRqyvzq1TKKDWm6ZfvL2BFliE6scyqmN6NBd9rVoq1HKW8x+D2uLOX1uEVboSBqtO8XiFDmv0OEBxef2L4HmkaaLN4dYRgHkJh8aH2Q6JcEN38Awbp89ZlRKVwFILhqcwjLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405740; c=relaxed/simple;
	bh=6FEl0ydSEqUmztcsL++8QqpfvnNJjl64p/2NIbt109w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1BMW5MnCn1ZY6EHkEDap4NAYYL1+imOlesJhHoms9hADNsl9Ag8FwkqP2ojRvLAGVLOsUxTNfcXGze+S8ZLPffK7x14qpJV8eZC/Wg3nTQAHffLAv318GFxIaX2hqoZCuIGZAn0OEmhqRMs/G1AOq/8ePjmO8XgaGB8FAUCnAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEcafbqk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEcafbqk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A63F1F000E9;
	Mon, 10 Aug 2026 23:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405739;
	bh=JKvG70cwNsr+FE59gb8BGQT0YijdRpaubdO/+HiUq0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YEcafbqkCSc7A5Rkx9TEml/OcY6+7rYjQLYm2/QNYferD36APdwi/+9kRV0394vF+
	 UEjGO6DxZUCqWSE9glmQyI6AeX9CegK0sYh3GjGvV/BXZjLSEGEfR7xef7NHPCAnZp
	 Oo/rJLgWZ6O5QUQs/biS98FBcYc3Z4l8LhJ/54IcL3OAV956xsX6dMbU+jDYgeFZtV
	 /DqY36PK+oN0yprbrFlooOek7voz2l+42hZYqZWqgaxlOwuHVkx5br8vNh1MuKmp/d
	 Bi+Naa/2o2Szk7iKSp5V1qvlKannB6eygnGax2TK4lRMtoNbqaY58ldqplhOa3Y+ey
	 sD83th20HZvbA==
Date: Mon, 10 Aug 2026 16:48:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net-next 1/2] selftests: drv-net: pace ethtool_std_stats
 packet generation
Message-ID: <20260810164858.7fdd834a@kernel.org>
In-Reply-To: <87ecg6cnm7.fsf@pmachata.org>
References: <20260808163653.2460381-1-kuba@kernel.org>
	<87ecg6cnm7.fsf@pmachata.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Aug 2026 11:48:32 +0200 Petr Machata wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> > mausezahn defaults to sending packets back to back at the maximum rate,
> > which can cause packet loss, especially if receiver is running a debug
> > kernel. Space the generated packets out (-d 10usec), like ethtool_rmon
> > already does.
> >
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>  
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>

FTR Petr send me a review tag on this off-list ;)
