Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E1A1E3DE5;
	Wed, 18 Feb 2026 01:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771377971; cv=none; b=RNcBGB4SEAM0h05He0DgXlA3DZk47Ra0khSxy0c3YFZ1cfAyJKbww4ut7muAacA/wERemeQ7QPkyiSDH+ZRXR+T3gAwQj98nIISyGu1aT68D9Kp+RyUN+d+ZJP34PCgBnIpxcC+AjVosl9cvzBvq5IDU62Dn9isYODQl2QBOGnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771377971; c=relaxed/simple;
	bh=OZNURT9nj0eHL8ZiQkdVSQMg3xYrnevJpqbmwVzZ080=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ivpCghUPJ4kdIikMGMlLAgsFuN/6QyY4VBu8gXZlM7Hev3zSSgpa/YT/QRAAZ1aKQyuwnkvrdvMXzOpWEUXVVA4TPoidGt6DafANrcLod0bp07mHZz6FdyYMMHHzG9f/3cORxOjlLqDOuk6UsPjZd45RjEAGcFARaP02qybpnfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRntqxQQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRntqxQQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6F31C4CEF7;
	Wed, 18 Feb 2026 01:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771377971;
	bh=OZNURT9nj0eHL8ZiQkdVSQMg3xYrnevJpqbmwVzZ080=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NRntqxQQpgJTdFpGPI6iTf+maAe44yBxEx4B6p+UUubZgbSyh77jQXO9JbIhrqRVr
	 /Y/kV9ykcLJVYNsEgkSQlfso+/WbdEBkzNSQCm+LkZy9zQr9nlDDyIsc5W0uI3mKOy
	 DP6l3iCZpNTMJZ2W0eEkM+1i5ToK7iDX57Bev3zUwdfP+jUy9sRvPHt8urwaMfUhyM
	 EtlofsfSeD7cex4+qTDqFeSan0DCJOBT/d61pErPeY0Ok4EGfvsCj2lAlCFdr+2KPZ
	 RWXALGLVSxp8G27Q4CpuNMvkXLKLLjEi6XHwVdMKNKKbN5PxJMGjV0YLqoHo7VZ3Nc
	 UbqDQXHknYAyA==
Date: Tue, 17 Feb 2026 17:26:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joshua Washington <joshwash@google.com>
Cc: netdev@vger.kernel.org, Harshitha Ramamurthy <hramamurthy@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Praveen
 Kaligineedi <pkaligineedi@google.com>, Rushil Gupta <rushilg@google.com>,
 Bailey Forrest <bcf@google.com>, linux-kernel@vger.kernel.org, Ankit Garg
 <nktgrg@google.com>, stable@vger.kernel.org, Jordan Rhee
 <jordanrhee@google.com>
Subject: Re: [PATCH net] gve: fix incorrect buffer cleanup in
 gve_tx_clean_pending_packets for QPL
Message-ID: <20260217172609.4c6ee746@kernel.org>
In-Reply-To: <20260214001226.744193-1-joshwash@google.com>
References: <20260214001226.744193-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Feb 2026 16:12:26 -0800 Joshua Washington wrote:
>  }
>  
> +static void gve_unmap_packet(struct device *dev,
> +			     struct gve_tx_pending_packet_dqo *pkt);
> +
>  /* gve_tx_free_desc - Cleans up all pending tx requests and buffers.

Per kernel coding style forward declarations should be avoided.
Please move the functions instead.
-- 
pw-bot: cr
