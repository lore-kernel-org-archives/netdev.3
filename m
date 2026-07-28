Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A0C370AC2
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785274038; cv=none; b=XnIwo5LlCzWCXKtDQ+5iXjwCAD1mxA/gcvDi1xWDGcldgHs1KkSLWKE7Nas8awxwL0HngmYWYSIRFYb2ZlV6BuWHNbEoC5JOuI54Cqq1tuSp6/iAEQwh8+Mwg2xtUL7ogEmVtf1cgv66AU9kxR5DPyRljN/Zk94JVj0af1hE1m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785274038; c=relaxed/simple;
	bh=pVwDNndB6VkIycka2OcZuSVaDrZ5R3DZguIEPrKS1p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2y0AzTGL4n4SGbPRXjYKMZgYPTkEkqmsByCCgjoYPStWiNpmyNA5NH2DTYshVaxBJJvlEV4lLpd0yJ5yIhCUTv9kMH5Cj2wf3yeDhTtj0ATUdqRhReREAt6wHFp+gvVuGXTd5/fQfOtjIeoldk8DtcXwYevaauH8CEam+JHwuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=m8K0qUAN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PWeuAVBS; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="m8K0qUAN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PWeuAVBS"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 477951D001C1;
	Tue, 28 Jul 2026 17:27:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 28 Jul 2026 17:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785274036; x=1785360436; bh=0xAUT66QWU
	eztpfwmdENxeDSckEA0ct+ipouGBKlTPA=; b=m8K0qUANCConrvjaGjnJPYMFIl
	Zg7dwsFsiekePOQuWP7f9EA0UQzbzWFYU1hLKyCfzIhEabx7dMOIZvVw1lVuJiDO
	0nwGI8pJLPOswN2pnV/S+OFz1Q8NqL/vN7FkG61gnDAuBZe1xuCL32HewOkUguAK
	UdnsWM+0jqRW0GeoqwLmB26ADSQIaDx6vGvsjKbttv5kApCfQdsw7/R32rY6WHfO
	BNg6W3Is9UYmskCS9ZK+EIxiLLotpx/reFgyCYQVEAVHy+O/zKhgiP6g0jW3Mwh+
	+0V17+Haxi/gFpNOg+q09rdyt1r+4ro/G02C/ic4IBdAFbbJVo3bg7Q/+pqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785274036; x=1785360436; bh=0xAUT66QWUeztpfwmdENxeDSckEA0ct+ipo
	uGBKlTPA=; b=PWeuAVBS9FB7y5qj2CAHGdhtDoDehqKvil1GiGNz7o6mQpu5w5M
	QdtA69uyvIF1VcdD/OQ3YmtIYQrEcFCzutj3b6QhON3LaRo4IW/VzSDKvFEB5S1h
	9Tt4HOlaXIP34PjcswyOnS7rIGg0jwluS+VkLY9dufyblYveaEYEpw3Ld0V5puEd
	n8wPT47YmRPjL/p+pgtwkIQ2NBcniPpugFQfUEvGMn88kjTpIgyY/fH13fSGE9Qj
	rnkCpG4cUzZLeUB58lUyzSU8vLhFPB/PnM91ttn4w/u/unMGB7U1kuiLAoxZ3cPH
	eXH6rVWXE1cEfoMQXpIGe0OFeqIYZ+lO7sw==
X-ME-Sender: <xms:tB5pajmnsXWM8vKz1LoxXVPbpCJmlZcK-hJ-k23hbKwKNc8F8KRQvw>
    <xme:tB5pat0pnLJPDmTtyT07Wzz6nFXiKC5sO_pK_xUo85qTqDj1q1BQWk3nDOHT5vaWq
    5jylXiD_fORk2I0QlnpVuD4j67dhy5UezlWZ0C8YNA3vMz2GZ7c__0>
X-ME-Received: <xmr:tB5paupuwAWawdGv8jomeYWNzw1ktOoAIfWVip1sGiHSIGEwxrWthNcSri6WpeAn6MKl9Olj_qstdhy0oG_9tAF9rmuCK00>
X-ME-Proxy-Cause: dmFkZTE/R0kG4uxg2bLw48YFNh/8g2lFcOYONckTV3r9kl8iJjwLZgA4MruOxRmwbpGQHo
    3q8o3/OJpsfBgLO16z7cuQyXIhj22jR+avSQLWkksfPknb+rlQTCxe13LkLmFUnio4f1PL
    DbmWc4nJiy+5yKlbz2o+Mk3OFMiZnmwThCb97u8ArwuWd5buBioXbPb64QO4v3Ubu6Rh/U
    gXe3y+QD3EpVr++w7ezWN8jqV9hVmsC/2+yXni95WWHXrlom2733s3t5Vet9Jxy6YsPx0b
    Vh+zj2W+b0mOgs94+72f/bTLo/Z3zwgIXG9e9uAjXSkpzPy2O5VnShSijFbo+1XC3P2WDw
    C5RtJyym8IGoIOPG3lj54B3UGkUY5Le/1NicYRahUAKlPrUyX05vix0hAg0UyF/0Gt0kQD
    lvr/ekyZmXgVCGqvgggBE/DAeR2u+9K/5PFYaEQ8hTRdVgTJ8Lkp+lbgFrxWQT4XLrpTpw
    jQwYOkI0BDWKe/4TVo7FM2wHYunGvR+xVdzJS5pYv0wW5lx0AjDfkKcpFj/idNP6h8DLhY
    xdQVjbLnNJkM3eUQOHK1rU2+q9ReJLAR2nowXPaQGS+ITB/X/G6UVnsv9ui39OqaaCHepS
    nlbUDHltHJX0cOtWAkIZE7M5pamImI0IAEnxVrE0RVEVS/9Q+XlxnGUReV4Q
X-ME-Proxy: <xmx:tB5paqeDbVuQrt3m6ehDwfevSbfdx6-NMCuZa5Lr0osQrNiu0HMOHQ>
    <xmx:tB5patpNHi_FeQ3SuAVI1Y6sK_YtOqdAxSZW4gKKyqJAjmk9NAKUAA>
    <xmx:tB5parFPZ2kLdV7n9U59qatHLTOgmaBiVWJiNzr8b6H3JLqeBc0kbA>
    <xmx:tB5patsHrS-D8AltEWJGKfG3womDYgmonyFixM71ltdmS-nPmORy3w>
    <xmx:tB5parwr8AQTbDR2RKxcvXDpyiSzyTGUHvLucPHx0wlaL_jndCopq4Fv>
Feedback-ID: i80b64ba7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jul 2026 17:27:15 -0400 (EDT)
Date: Tue, 28 Jul 2026 16:27:15 -0500
From: Juanlu Herrero <juanlu@fastmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: David Wei <dw@davidwei.uk>, netdev@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>
Subject: Re: [PATCH net-next v3 6/6] selftests: net: add rss_multiqueue test
 variant to iou-zcrx
Message-ID: <amkehmLCFg_sZtTE@jlhe0197-mac>
References: <20260722203950.58550-1-juanlu@fastmail.com>
 <20260722203950.58550-7-juanlu@fastmail.com>
 <20260727183731.1537e158@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727183731.1537e158@kernel.org>

On Mon, Jul 27, 2026 at 06:37:31PM -0600, Jakub Kicinski wrote:
> On Wed, 22 Jul 2026 15:39:50 -0500 Juanlu Herrero wrote:
> > +def rss_multiqueue(cfg):
> > +    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
> > +    channels = channels['combined-count']
> > +    if channels < 3:
> 
> Please add doc strings for the new non-private functions?

makes sense, and I will fix it in v4 of this patchset.
