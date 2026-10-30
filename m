Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365447;
	b=i5ZlBgZi2F4t5Z5hGiLqlR9q6681ymOCGUUuLNWqAxXseuT+OgcGLlSi+yW7XsIZMXdc
	 kSiA1kyBz8lJPhDpVYVugPsJmqzZt0opMh7ZxE/vhUZPx70IJiVbocJXWx/b0X9IzzMFW
	 z0s4QzkWvTsY/8gWZzSIMUUG0BkNweVq4guxtyJe0nl6FtvIUb7aXVnLpiF2JbGpnUeKM
	 uJBCK0zC5h+hFXgoq3+/GkEvxvjqwJDIxzeSk5KoySUOtb5YbZOS8YSuwJ61JgqFgSjnk
	 KkrIOh1Uw/8R+Syfsbtd3KNxWMP8S9fY9OjL2WvjiltPZoDu93iO4eP+WjXWlI0sJRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365447;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=ndnBPSa7Ek+2movT8zZbZYtWlw1gy/RQsPjt4uHgKibYoSpg0iIc7EAGxUuferOvZ/hA
	 J8nuL9xG9bJKQpeK0p+SbzNKpHNeYkaYsdgjWdoer7ESxXDKFVNjGxcHHlp70dYbVIenC
	 7fHvUbiUoNnMv3EquSM4SaKjUMFEsjTa8Vs+kzt3mZsV3eMg4FQyhA2qWYNNt/Bkhl6qu
	 poePqATNmEI36wno9EwKKuPfZHMKKSm7PiR9jfpX2VLtpBgZGxj0Wkzcq65qQIxVlgOzd
	 QlWZZZB47p9JNoqfmuomQ8DUCCLmmUBQbCuveDAhFFvSqNii8knkNoSbs8GQ/hb5Gvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Um2ltukU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D10606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Um2ltukU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D5F1F000C1;
	Fri, 30 Oct 2026 13:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793365446;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Um2ltukUXCk8jMKSxBljcopWS9/iBvnh0YEj6B3bGCJoSNG5hu69kHsnhyruxynpu
	 G59SVoWDnbINxtSrdVYs8/6hPL62XrWTB9R14BK7B2x0A9z6HPk+71xBfF5IV7hjeu
	 H68UUYLawwf+bfE/EhCr/uohdwe9p7tk2WxmsMN8LmHvyOU0wmRwhX6yG64gESPkNB
	 s3+XWq/OLbQRnWYd4R57+AijmHhmOJ0ArpqO4KqSn49cuMxUSD6O1ciDRLnAsckbAz
	 zxF4/Dr2f3ODWGSUpuuJpeReBEGVehYK4Bn9LeVvVW2UhJSa1QMm3PY0QUwEC2EQ+P
	 AY3ECq57PsFfw==
From: netdev-bot+sinfo@kernel.org
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Tom Herbert <tom@herbertland.com>, Cen Zhang <cenzhang@linux.microsoft.com>,
 AutonomousCodeSecurity@microsoft.com
Subject: Re: [PATCH net v2 0/2] net: gro: fix frag0 and remcsum handling
Date: Fri, 30 Oct 2026 13:04:05 +0000
Message-ID: <179336544541.3327.17240144179594793846@kernel.org>
In-Reply-To: <20261030125955.3107383-1-edumazet@kernel.org>
References: <20261030125955.3107383-1-edumazet@kernel.org>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
