Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241F3B5DEE
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 20:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781555987; cv=none; b=eBSKmXnVIWeAMPMrWgnvSk8YYXBC4sZNGky/OMCG1jcfoahNJ2lJ62774aRGMJDnx60bfv1fwr1XFRcgQD1vuy5j7uFUAI1V30BSx78xDJwmzbOWYFdnOxAAW926pp2/JOKHQ4O7CLVjn8wLpza7k5XL3w6hZrj0WSGGsh32coU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781555987; c=relaxed/simple;
	bh=CXn1z1gPeSrZCNbtHq24gR5WRMNrngE9ogf/o3qz4fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJewYXs3g4/F6v+NZW23qWfK3k8aDnwnDIyasRbWPMYqsfv+iSN6YFfG56nozk9zrqdZWwUyq+Z39oXKqBBPvqQJYdopAg3/PmbdY/ganJV0NxfTAUDr8DAKTaNbaCPNjKSVUsqeWG2DBdrOwfYgxBW+3wUO1TlLcJfP+Z26NmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceijp5wK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceijp5wK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEC01F000E9;
	Mon, 15 Jun 2026 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781555986;
	bh=/Zml9Z4FF9aHVytLRahfWrVDKVXZ5Lp7aUpoDTgcOl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ceijp5wKhtLCVqq3vVflxkEX/viU/9AEH/GwD8gQaP7Kj5/gbOUPa3D3Gj4H//PpZ
	 PKQFO5zY7ZGcAzvgf72hLyCID7ucYNX4RKk/njmW25rppqKrCeITljQ5AHSGQzyTGH
	 MAN33FtJwZO5H/oO2vJeJZ8GXvErPrdFq0h24FRkKS+6q+hDa+YjLS2n1Xa9EfH++D
	 jflrTe741rynWzO7m/3UrALgqEdQUWtPM25sWxSRTz02pYJvNTdXxe4TKIqctSaYIg
	 lzid3yTHCp+0YBSCzihYXXcdxnw7zHbTuUlNmJKSbsh55ezzzhO8S3PPKFy5xrfJ80
	 wCUbEy8UcEauA==
Date: Mon, 15 Jun 2026 13:39:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wongi Lee <qw3rtyp0@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, asml.silence@gmail.com, dhowells@redhat.com,
 willemb@google.com, Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: [PATCH net v3 2/2] ipv6: account for fraggap on the paged
 allocation path
Message-ID: <20260615133945.6e94c2d9@kernel.org>
In-Reply-To: <aiq5VQknt1QHcvio@DESKTOP-19IMU7U.localdomain>
References: <aiq3f7UZGFp0F3MV@DESKTOP-19IMU7U.localdomain>
	<aiq5VQknt1QHcvio@DESKTOP-19IMU7U.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jun 2026 22:34:13 +0900 Wongi Lee wrote:
>  			copy = datalen - transhdrlen - fraggap - pagedlen;
> -			/* [!] NOTE: copy may be negative if pagedlen>0
> -			 * because then the equation may reduces to -fraggap.
> -			 */
>  			if (copy < 0 && !(flags & MSG_SPLICE_PAGES)) {

You remove the comment because copy can never be negative with
pagedlen>0 now, can we not remove "!(flags & MSG_SPLICE_PAGES)"
as well then?
