Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591777;
	b=wIsMJDTWRrrDmJIhsvHyvCgfVqezWmYcTA6KzGgSl+dorGHMdy4ZnPPqc4y9z9EB97Sb
	 +y5xR707w0lpCcxmq1ljYmlJQwHptM9c8OECHJYYCj2ZslqVjsFvcOBzl7Qw1ITGpNeD7
	 UyuIH0aBpxRyh7/iJQ63RISxawkznal1U7FlctcjixRvnNY85Ugabjb2Iv8c6pfwP+Wh0
	 VyGYq6VxVTk9sCRRk0I6tJSFx1k8v+kLCGo7T6xh6CVQHSurAceX3G0E6g+xmIt4rNaYW
	 F/TATd5Ux1+eoh5KXY1IGqbNcHbM+FhyBGn0vr8V6TaGFrWjSLBtHmDV+xQRyvzq3UQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591777;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=IYvcfGb/slu58PM/m4e+Yc8z7FJ8K/oScmbq+QLPvBU=;
	b=QUl8Ng2oaCEI7F+kLuedmotVI6mym7ZzicEE0j1zb/24x1lz/iRTqIrTP8+4YhCUxXMP
	 rAUs73ybImGoOYrmYu22w1xCQr3pudkghOUySUu75YfvtQt4qM4ZTtmejqpojpKvFmL8Y
	 Kmq5U7zeQKhfKltXnTI0Bs7rwSKLn5taGtBn9WGThqiqDsFZklhKJvNUuUPYNSlraNtOb
	 zRDNhiqKSIOW0bEA099yHPhyJScyLqL5d5sqeh9gOlkI2SEx9T1G9odJfJA/dgOt9HQgm
	 z6ZE1Q1jwE8wJDlPJorFNNq7uTi6GiW9j/gNgbcJ7Sg0X+n0EYDVwNbWZcl7rs6Eecw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OiMnETWV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F81606B369;
	Fri, 13 Nov 2026 17:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OiMnETWV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6A971F000C4;
	Fri, 13 Nov 2026 17:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591777;
	bh=IYvcfGb/slu58PM/m4e+Yc8z7FJ8K/oScmbq+QLPvBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OiMnETWVNrC+PUULxWlaoousk14+Ub0hS1/4hS6n6AToB34KRUeMJKSvRmUMvWrmB
	 ddKR+DwvFNgpkWG9r2uoJ2nCkxuPw/zDoUqP9oXW0VjfYGH8c8Oz8Z9HDhYUmlmtrG
	 U4GIoU9jVkvSyKqCalob3PFhgDCres5WEX65I14+1d27QmqILveEcgOQQb3O08S8AZ
	 v7WUpK8SNAB+Rn/emnt+9SupVYCDhr+bwKCeoINC1vZGdaJECLLAsamI/5zQW1upRa
	 JlZUglx99ghE9WhA9FFabMiLsCf5f1A8lRz4NtFIA1rbPMfk5OJcevD6fyhvgYpqQF
	 8nnDlffKCYUnw==
Date: Fri, 13 Nov 2026 17:42:51 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Alan Brady <alan.brady@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Willem de Bruijn <willemb@google.com>,
	Shailendra Bhatnagar <shailendra.bhatnagar@intel.com>,
	Pavan Kumar Linga <pavan.kumar.linga@intel.com>,
	Phani Burra <phani.r.burra@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] idpf: reset mb_wait_count once the mailbox is up
Message-ID: <20261113174251.GA18859@horms.kernel.org>
References: <20261109-idpf-mb-wait-count-v1-1-c6584754df78@debian.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-idpf-mb-wait-count-v1-1-c6584754df78@debian.org>

On Mon, Nov 09, 2026 at 06:43:27AM -0800, Breno Leitao wrote:
> idpf_vc_core_init() retries a failed virtchnl version and capabilities
> handshake up to IDPF_MB_MAX_ERR times before it gives up on the device.
> Each failure increments adapter->mb_wait_count, but nothing ever clears
> it, so the limit is shared by every initialization in the lifetime of
> the adapter, including the one done by each reset.
> 
> A device that fails the first handshake after a reset, and then
> recovers on the retry, leaves one count behind per reset. Once 20 have
> accumulated, the next failure is final, and the device stays down until
> the driver is reloaded. This is seen in Meta's fleet on hosts with
> recurring Tx timeouts:
> 
>   [ 2176.496801] idpf 0016:01:00.0 eth1: Detected Tx timeout: Count 21, Queue 11
>   [ 2176.508763] idpf 0016:01:00.0: Device HW Reset initiated
>   [ 2237.412541] idpf 0016:01:00.0: Transaction timed-out (op:1 cookie:9800 vc_op:1 salt:98 timeout:60000ms)
>   [ 2237.412578] idpf 0016:01:00.0: Failed to establish mailbox communications with hardware
> 
> Clear mb_wait_count once the handshake succeeds, so the limit applies
> to consecutive failures only.
> 
> Fixes: 4930fbf419a7 ("idpf: add core init and interrupt request")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>

Tony, maybe this should be routed via the iwl tree?
