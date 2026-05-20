Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D5C3BE642;
	Wed, 20 May 2026 22:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315372; cv=none; b=iteDpIBS3aIZuUUzZHRhW52oew6/+hJeFyg4tn2U5hwdpwNq+EziExgGKRj97t4nygwR8MC2o+aFIn/Obhnlc/k239OEKcznQftcqVwxvRVvMzpRmutwSn2RzKVJQ9KwVe5GVqfrSoXb9PEMdyGP5OquQ9hu65nfmSXcJRB08LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315372; c=relaxed/simple;
	bh=c/oDHDdVGvSyLqzoLzBh8Avjt+YlOJI5jmoykGAOf/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXir68NwqsL+xgOWwy7b2R6NM1eDistbDZcNb06ogbeDGOuV5mZq5g1WRKlNdCXLj+70NliLc2QeGdTF+ry8/fn0sIO+qX/iF7J7rrbOF9cmMwwSuGJChTdSyN4yqa7R+4vomig17O1VH4+AeimvfbNNbGGQdBRFFBNei1LVAbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tbk8kwOS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tbk8kwOS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0897A1F000E9;
	Wed, 20 May 2026 22:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779315371;
	bh=c/oDHDdVGvSyLqzoLzBh8Avjt+YlOJI5jmoykGAOf/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tbk8kwOSJntaBrA7WS58xqdsZ4XdjJLNBvtCcXHpneMh2pudjAzO0rpVCax0rDUIO
	 y1PCo6X+wCq/lJKIzsTsBmlrustqsr6xZz3HGJhtoqDORVZz2pnPiUdmuLydtSKz1w
	 WZQlxK+PEk1yKQLAWE2rE6Tc8hUZZq3ZsxToqOsyvGVKPV60rCjamMl1DsgFFAZm0M
	 MzMpgpgNGjuXffjV58mi7IWzl1OKwL+UxqujP/TYchjJcoLozA7PM8zTiAGvfmlSHJ
	 xXSLpB8+Nn89lQcIke/XU+EAbHh/mGQn3/jZPzOTnLBicLSV28Sv82ciOgFvWOIn0K
	 cvyjYzRVIrenw==
Date: Wed, 20 May 2026 15:16:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org,
 joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
 jstultz@google.com, sboyd@kernel.org, willemb@google.com,
 nktgrg@google.com, jfraker@google.com, ziweixiao@google.com,
 maolson@google.com, jordanrhee@google.com, thostet@google.com,
 alok.a.tiwari@oracle.com, pkaligineedi@google.com, horms@kernel.org,
 dwmw2@infradead.org, jacob.e.keller@intel.com, yyd@google.com,
 jefrogers@google.com, linux-kernel@vger.kernel.org, Naman Gulati
 <namangulati@google.com>
Subject: Re: [PATCH net-next v8 3/3] gve: implement PTP gettimex64
Message-ID: <20260520151609.7e7272ac@kernel.org>
In-Reply-To: <87mrxtwzz9.ffs@tglx>
References: <20260514225842.110706-1-hramamurthy@google.com>
	<20260514225842.110706-4-hramamurthy@google.com>
	<87mrxtwzz9.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 23:08:42 +0200 Thomas Gleixner wrote:
> Jakub, please back out this hackery before it makes a precedence for others
> to copy from.

Done! 0ae361f7e43c in net-next.

I'd also appreciate if you could cast your eyes over:
https://lore.kernel.org/20260515164033.6403-3-akiyano@amazon.com
Different kettle of fish, but firmly more time than network..
