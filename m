Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E7544A41D
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 22:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598751; cv=none; b=ilAf11Sx4f3tSzA303eTRq7B0vWyqMG2wPlQe+zp5eqH9MMk6L4xKQ5KQ6W3R0ISb2KqnMiliN7xvFEmglICAGZ6FW2BcclZZH408DsQ9zt+WfsFMX3uJpBiQcVs+pNfo3hC7anBTZYUb4GPyR2h3yOuyOPeKXQI97cYomBtw8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598751; c=relaxed/simple;
	bh=OGHasgX+EgBEafVBqx+AATjqeLNZtkRFQao98gbxNUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSC8nKzaSJzb4cjeDpfa474x4R5EAHEgiuFfP7wZntyjYXdbzM8QC3nW2YvGEfS1OEYQlrWceaVIjPf+6KeWdwW6vZQ/sGyT228N3Shl04bF0Qrx1WOuDC/23VYSrv0R3aU0eAcR+EwezmHJciTZxPfdV7J2pJwrS6WEAk2HLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=btKBvs6j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="btKBvs6j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F901F000FF;
	Wed, 16 Sep 2026 22:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789598745;
	bh=OGHasgX+EgBEafVBqx+AATjqeLNZtkRFQao98gbxNUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=btKBvs6jY8uGHMFZIWok5Mxh8G7yj8p2qnTEr7a6CueR5Gd+LkLfwoy6R8dX6RuCU
	 eAYvJe7dKxLTeeMjRM8fRcGuN5zCasW0rlXLmnVsqHSX17g2QBraL07IAbcuUhszVj
	 BjqltowHGWnkOMJsPmVZi/eC0Ip94/4ZCZRTelnI47lNrM4lfwJQ1v/vpSc0mpoaZL
	 n+h+vfFRhMvnOkOB1ApIOcuicPqCOZ+td3TopgUQTzacDoR05FRbEm+MLXsS/pcXYE
	 Yo9d6PqbzlWrxou6NxarhiuRW3TARUXVEqP56BNJlr6RYWDOCG972UolW18p59ci8Y
	 Wi8B/dAH6AssA==
Date: Wed, 16 Sep 2026 15:45:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, idosch@nvidia.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
Subject: Re: [PATCH net v2 0/5] ip_tunnel, ip_gre: fix changelink lengths
 and ERSPAN receive
Message-ID: <20260916154544.4cada4cc@kernel.org>
In-Reply-To: <20260916100155.1398403-1-edumazet@google.com>
References: <20260912150944.3470971-1-edumazet@google.com>
	<20260916100155.1398403-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Sep 2026 10:01:50 +0000 Eric Dumazet wrote:
> X-Mailer: git-send-email 2.55.0.1032.g73a4cd73de-goog

Did you ask an agent to send this? :/
No postings in reply to old postings.
It breaks sashiko from time to time.
