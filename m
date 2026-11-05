Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910784;
	b=MNnWhiqUEqnleNlL+I2U4aTxe6zg929cQm7w0ANSpRFFbCPjiYGIr0W84jWQ8eyIWMxC
	 dYOvaq0Q561eRaVB9Mf9nbaph45+JZoaCRy3Dypt/joAsE+eBil//8QkDYkToowdcNg76
	 o7tHJB0sLCvp/P9mx77AqrtbXNRbYs9uLBEUVhK/Ppbfs5XmruzIPUCNKaaxk3deG4BfH
	 wqnC/R4UXTBqFUaD37pYGHaMqa54TJTbNAMitO3mJjcitOGa/Lh7jJXISZaO1aH9pHzGE
	 JR1chf4YzxYKrY8eWwQziUuxYaBl01L6yHPRCzEZ6trP6o8QIwOlZCrS9ULfBMSwv0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910784;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=jIYSdDAT/fq5e9TIqP3VgSsPnw0BT8aJhl0gIkzIiQ8=;
	b=ITJfPS0RsIlJYsIV3csefQIbvgPMLcYOsVIyQNHayz1bsbE5FWekso0TLh5tMwj+5Haz
	 QzlkLbvQ3tUHY2cAP+0yOdoE5Sg69BOHBrvLVAuBJ6EgqcnOG3ygnIQ1rYDPRkRLZ5BtA
	 3vyxE3hZVED4nJve6BpLTQPKkJP3ZtPPG8ecrL5a5G5GCE9/4PkD6qnK1YVapjEavI3Rh
	 t3/eVZPeIT5m/3IwtIJmB3qWvcSPYbki9oa4vNfJoZBzCrw5/84cphdXGE/uQGdK1sB69
	 2GCWXSPdbDRiYa5AUc2ULQee3xnLlgl5j3DTFEOCfvjl8wX/MatB2hNX0Z7wVx9PVlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0K5CHW1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5B2606A330;
	Thu,  5 Nov 2026 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D0K5CHW1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B102D1F0089F;
	Thu,  5 Nov 2026 20:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793910783;
	bh=jIYSdDAT/fq5e9TIqP3VgSsPnw0BT8aJhl0gIkzIiQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D0K5CHW1HbHowbUTxBTxlAxvGr9sElImvItyEM0o4MfiXR3lk0EU0YiwHaisFW5Lt
	 u8L9poTHIgPTACX0gONP/WnZSUo4PJWXARLyoetHMsL9VWV2W7Kb7pUxigqmKt4lBl
	 OnNvWjJX8iVwISEyJxpIfFx2JmOjiVH495Toi13kt4iaNE77csnCizICpD8Ss3C0eA
	 Rr75Fb9deiWxCmxCAW647/9gtXlC8rBmqXxZlf0WkLbiqPS2aIQtpk0J9k9CaxMfDB
	 l1EtjFVKtun6Ufkabk9GX6slDxUbyv8dbDVC9TAbv0h2Pye3vRZKYbqfVXQTXx3U1L
	 bc8NJuOWrjL2g==
Date: Thu, 5 Nov 2026 20:32:58 +0000
From: Simon Horman <horms@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net-next v5 6/6] net: usb: r8152: Move long delayed work
 on system_dfl_long_wq
Message-ID: <20261105203258.GA865646@horms.kernel.org>
References: <20261102105703.111844-1-marco.crivellari@suse.com>
 <20261102105703.111844-7-marco.crivellari@suse.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261102105703.111844-7-marco.crivellari@suse.com>

On Mon, Nov 02, 2026 at 11:56:56AM +0100, Marco Crivellari wrote:
> Currently the code enqueue work items using {queue|mod}_delayed_work(),
> using system_long_wq. This workqueue should be used when long works are
> expected and it is a per-cpu workqueue.
> 
> The function(s) end up calling __queue_delayed_work(), which set a global
> timer that could fire anywhere, enqueuing the work where the timer fired.
> 
> Unbound works could benefit from scheduler task placement, to optimize
> performance and power consumption. Long work shouldn't stick to a single
> CPU.
> 
> Recently, a new unbound workqueue specific for long running work has
> been added:
> 
>     c116737e972e ("workqueue: Add system_dfl_long_wq for long unbound works")
> 
> Since the workqueue work doesn't rely on per-cpu variables, there is no
> obvious reason that justify the use of a per-cpu workqueue. So change
> system_long_wq with system_dfl_long_wq so that the work may benefit from
> scheduler task placement.
> 
> Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

Reviewed-by: Simon Horman <horms@kernel.org>

