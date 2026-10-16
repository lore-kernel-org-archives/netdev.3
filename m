Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9A744E038;
	Fri, 16 Oct 2026 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164104; cv=none; b=MvB4rRmQAZCALkWRk1aL3vCe+N/N0mY/lvOXUElpi9HWRLbpOl/1cdKp9+tmVFHecqLq5D7RxUy5pKd7wqM6cNe7Tlol4BjJzisivUP/cC4YKD3dhGp7EpeVrrAdmdvCzhz7j4HD9neHj6tCnDz5PW7M/3OkNxYGVBE1vLGdylM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164104; c=relaxed/simple;
	bh=HkK76i/k21x5cMlby7axJXerijSnJJdRGmfbxqz69m0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OhiGq6VwYQAm3yNyCOPbetexqs7eu/JAEivIUECyas2oQtXj1K9hWr8QZJE2o1aQnTMXQ74ihelJHYYLK8hl8SuLx0YLeD0aeud11SgAsa/Q5OaOwOsGwwHp0JnKrrUTmcXMoaFh4q4e0ahJqtccUViapFzS2+WoRYqx/ApMp5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vd7NqNsA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vd7NqNsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541431F000C4;
	Fri, 16 Oct 2026 15:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792164102;
	bh=HkK76i/k21x5cMlby7axJXerijSnJJdRGmfbxqz69m0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Vd7NqNsARv93YzMJv2SecIb+f8zD2yC5s3GJkzlIerLRSKzZvb1OiETiR8vFDdgrj
	 zgj0m15Zi9FOgtwZgXPr/ThT9roYr340rr/bMiRd9ilHTRWsjAvWUJbxodHZAYMkJ4
	 GPXSXiSI6eyi0Il1cA7J19OZOaO8NsL1WBPOUo2HBbFEKbdNmwDbQL5suuuTfeQB2K
	 sktrAladKzfp1b6DZO7T68ZPY1pVSisspyDyLmge0Zm2bu02sdLtxmTB37PFni+xvb
	 2yA3o+auzCscGXjuAD1BpYKHFmkLF5TaCzy6zuY/tVGQ4cVlrjPf4tth2/ywbnDcMQ
	 4HWQUPMCz1Nmg==
Date: Fri, 16 Oct 2026 08:21:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, Russell King
 <linux@armlinux.org.uk>, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, Petr Machata
 <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [PATCH net-next v19 0/6] net: dsa: mxl862xx: devlink flash and
 rescue
Message-ID: <20261016082141.53c3a5c4@kernel.org>
In-Reply-To: <cover.1791035885.git.daniel@makrotopia.org>
References: <cover.1791035885.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 3 Oct 2026 16:50:44 +0100 Daniel Golle wrote:
> This series adds "devlink dev flash" and "devlink dev info" support to
> the MaxLinear MxL862xx DSA driver, and makes a switch stuck in its
> MCUboot loader recoverable through the same path.

Please come back once you get an ack on the driver core change.
IMO this is over-complicated, mlxsw just flashes at probe, for
example. Maybe Ido and Petr have an opinion.
