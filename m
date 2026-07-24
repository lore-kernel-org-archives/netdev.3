Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB241D23E
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784885188; cv=none; b=GDy0fLy5lchPjD8nNi4oDlmReumXvcTr1UxoJNBs1mE722kQfhzcwLrDdRCaltx3He6NP8EbM3YYPuK4yZ56j/eSoQe5ekldScBmcduhWn7tiAyZB+Fe1VDYqTC/y8XhfKupaIIuAGITnNk/1TG73UJ5IbmfXgR+Fs5H/2gGjxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784885188; c=relaxed/simple;
	bh=TOYGG2r6rWDxAQVxWwNmbbfL0CHEzm2/fYyLg3lYaRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqa/y6vhtpAtN/U3EDfWqQUPufL2WOoDulTllEiMPtJccflAQsGf1eoj2o4hZ8unU4s3O72lYTLCbZw3QK12RWp7PP4ewKWe6yMkATRaT/KlYCE+dqFfU82oVNHqYVCEPBpHGylYR3jnuvDDXHxAj5vLLHcQHfLjpl6ryIZKalU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZWrLWUyb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWrLWUyb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784885182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oqWyamKGzTmZpBj9R37rE6AHcNhkExyf2Dx6MVBVbCw=;
	b=ZWrLWUybiwOB5pQoGsaj8ogOcMEjncR63SjKhKKQWhmhg+mlS/oq5SX5jR3ZKfHVZSep2Z
	Kqj8k4XQlKkHCLq+0QhVBIBM2S+n7ep91NTIitbP5FKdsnsnE5Wg+KcsQPZk8cj05V6JP6
	si+Lvzr7rnJkez1Wl+NCeyDyrYr2faA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-hSIDnd_IOQCiSIHjyvaQbA-1; Fri,
 24 Jul 2026 05:26:19 -0400
X-MC-Unique: hSIDnd_IOQCiSIHjyvaQbA-1
X-Mimecast-MFC-AGG-ID: hSIDnd_IOQCiSIHjyvaQbA_1784885177
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BC8211830314;
	Fri, 24 Jul 2026 09:26:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.67])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 33BED195605F;
	Fri, 24 Jul 2026 09:26:14 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH net-next 0/2] docs: netdev: a couple of updates
Date: Fri, 24 Jul 2026 11:24:03 +0200
Message-ID: <cover.1784884817.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Explicitly covers a couple of relevant spots currently left out in the
dark. Likely the first one was too obvious to ever spell out loud and
the latter too new.

Both cases are increasingly relevant, at least to me.

Keep the update in the netdev subsystem, as others may have slightly
different preferences.

Paolo Abeni (2):
  docs: netdev: clarify handling of idle patches
  docs: netdev: clarify expected interactions with LLMs

 Documentation/process/maintainer-netdev.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

-- 
2.55.0

